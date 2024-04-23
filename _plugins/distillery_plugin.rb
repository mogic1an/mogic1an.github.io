module DistilleryPlugin
  class DistilleryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      # group by
      #site["distillery_infos"].each do |post|
      #  Jekyll.logger.warn "Expected a hash but got #{post.title}"
      #end
      site.posts.docs.group_by{|post| post['distillery']}.each do |distillery, posts|
        # INFO: consider add other posts with the distillery in tag in here
        site.pages << DistilleryPage.new(site, distillery, posts)
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class DistilleryPage < Jekyll::Page
    def initialize(site, distillery, posts)
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = distillery # the directory the page will reside in.

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
