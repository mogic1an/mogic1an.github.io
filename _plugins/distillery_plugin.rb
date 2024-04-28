def slugify(str)
  return str.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
end

module DistilleryPlugin
  class DistilleryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      grouped_posts = Hash[site.posts.docs.flat_map { |post| Array(post["distillery"])
        &.map { |distillery| [distillery, post] } }.group_by(&:first)]
      grouped_notes = Hash[site.collections['notes'].docs.flat_map { |post| Array(post["distillery"])
        &.map { |distillery| [distillery, post] } }.group_by(&:first)]
      site.data["distilleries"].each do |distillery|
          site.pages << DistilleryPage.new(site, distillery, Array(grouped_posts[distillery]), 
                                           Array(grouped_notes[distillery]))
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class DistilleryPage < Jekyll::Page
    def initialize(site, distillery, post_pairs, note_pairs)
      posts = post_pairs.map {|bottler, post| post}
      notes = note_pairs.map {|bottler, post| post}
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = slugify(distillery) # the directory the page will reside in.

      # All pages have the same filename, so define attributes straight away.
      @basename = 'index' # filename without the extension.
      @ext      = '.html'      # the extension.
      @name     = 'index.html' # basically @basename + @ext.

      # Initialize data hash with a key pointing to all posts under current category.
      # This allows accessing the list in a template via `page.linked_docs`.
      @data = {
        'title' => distillery,
        'related_posts' => posts,
        'related_notes' => notes
      }

      # Look up front matter defaults scoped to type `categories`, if given key
      # doesn't exist in the `data` hash.
      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(relative_path, :distilleries, key)
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
