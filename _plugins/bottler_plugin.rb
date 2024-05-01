def slugify(str)
  return str.downcase.strip.gsub(' ', '-').gsub('.', '-').gsub(/[^\w-]/, '')
end

module BottlerPlugin
  class BottlerPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      grouped_posts = Hash[site.posts.docs.flat_map { |post| Array(post["bottler"])
        &.map { |bottler| [bottler, post] } }.group_by(&:first)]
      grouped_notes = Hash[site.collections['notes'].docs.flat_map { |post| Array(post["bottler"])
        &.map { |bottler| [bottler, post] } }.group_by(&:first)]

      #grouped_data = (site.posts.docs + site.collections['bottler_infos'].docs + site.collections['notes'].docs)
      #  .flat_map { |post| Array(post["bottler"])&.map { |bottler| [bottler, post] } }
      #  .group_by(&:first)
      #  .transform_values { |values| values.map(&:last) }
      # group by
      #grouped_data.each do |bottler, posts|
      site.data["bottlers"].each do |bottler|
        # INFO: consider add other posts with the distillery in tag in here
        site.pages << BottlerPage.new(site, bottler, Array(grouped_posts[bottler]), 
                                      Array(grouped_notes[bottler]))
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class BottlerPage < Jekyll::Page
    def initialize(site, bottler, post_pairs, note_pairs)
      posts = post_pairs.map {|bottler, post| post}
      notes = note_pairs.map {|bottler, note| note}
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = slugify(bottler) # the directory the page will reside in.
      @path = slugify(bottler)

      # All pages have the same filename, so define attributes straight away.
      @basename = 'index' # filename without the extension.
      @ext      = '.html'      # the extension.
      @name     = 'index.html' # basically @basename + @ext.

      # Initialize data hash with a key pointing to all posts under current category.
      # This allows accessing the list in a template via `page.linked_docs`.
      @data = {
        'title' => bottler,
        'related_posts' => posts,
        'related_notes' => notes
      }

      # Look up front matter defaults scoped to type `categories`, if given key
      # doesn't exist in the `data` hash.
      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(relative_path, :bottlers, key)
      end
    end

    # Placeholders that are used in constructing page URL.
    def url_placeholders
      {
        :path       => @dir,
        :basename   => '',
        :output_ext => output_ext,
      }
    end
  end
end
