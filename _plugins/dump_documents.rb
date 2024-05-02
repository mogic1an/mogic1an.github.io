require 'json'
require 'date'

def clean_content(str)
  return Loofah.fragment(str).scrub!(:strip).text.gsub('\n', ' ')
end

Jekyll::Hooks.register :site, :post_render do |site|
  # INFO: search for infos, posts, and blogs (all collections)
  documents = []
  cnt = 0
  site.collections.values.flat_map {|collection| collection.docs}.each do |page|
    if page.data["date"]
      date = page.data["date"].to_time.iso8601(3)
    else
      date = Time.now.iso8601(3)
    end
    documents << {
      "id" => cnt,
      "url" => site.config["url"] + site.config["baseurl"] + page.url,
      "title" => page.data["title"],
      "body" => clean_content(page.content),
      "date" => date
    }
    cnt += 1
  end
  site.data["documents"] = documents
  File.open('doc.json', 'w') do |f|
    f.write(documents.to_json)
  end
end
