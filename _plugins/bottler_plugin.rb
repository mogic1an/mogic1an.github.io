module BottlerPlugin
  class BottlerPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      grouped_data = site.posts.docs
        .flat_map { |post| post["bottler"]&.map { |bottler| [bottler, post] } }
        .group_by(&:first)
        .transform_values { |values| values.map(&:last) }
      # group by
      grouped_data.each do |bottler, posts|
        # INFO: consider add other posts with the distillery in tag in here
        site.pages << BottlerPage.new(site, bottler, posts)
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class BottlerPage < Jekyll::Page
    def initialize(site, bottler, posts)
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = bottler # the directory the page will reside in.

      # All pages have the same filename, so define attributes straight away.
      @basename = 'index' # filename without the extension.
      @ext      = '.html'      # the extension.
      @name     = 'index.html' # basically @basename + @ext.

      # Initialize data hash with a key pointing to all posts under current category.
      # This allows accessing the list in a template via `page.linked_docs`.
      @data = {
        'linked_docs' => posts
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
