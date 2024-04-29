require 'json'
#    "id": {{ counter }},
#    "url": "{{ site.url }}{{site.baseurl}}{{ page.url }}",
#    "title": "{{ page.title }}",
#    "body": "{{ page.date | date: "%Y/%m/%d" }} - {{ page.content | markdownify | replace: '.', '. ' | replace: '</h2>', ': ' | replace: '</h3>', ': ' | replace: '</h4>', ': ' | replace: '</p>', ' ' | strip_html | strip_newlines | replace: '  ', ' ' | replace: '"', ' ' }}"{% assign counter = counter | plus: 1 %}
#    }{% if forloop.last %}{% else %}, {% endif %}{% endfor %}];

def clean_content(str)
  return Loofah.fragment(str).scrub!(:strip).text.gsub('\n', ' ')
end

Jekyll::Hooks.register :site, :post_render do |site|
  # INFO: search for infos, posts, and blogs (all collections)
  documents = []
  cnt = 0
  site.collections.values.flat_map {|collection| collection.docs}.each do |page|
    documents << {
      "id" => cnt,
      "url" => site.config["url"] + site.config["baseurl"] + page.url,
      "title" => page.data["title"],
      "body" => clean_content(page.content)
    }
    cnt += 1
  end
  site.data["documents"] = documents
  File.open('doc.json', 'w') do |f|
    f.write(documents.to_json)
  end
end
