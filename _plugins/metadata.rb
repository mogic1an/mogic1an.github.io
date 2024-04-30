distillery_regions = ["Highland", "Lowland", "Speyside", "Cambell Town", "Islay", "Islands"]

# edit metadata
Jekyll::Hooks.register :site, :post_read do |site|
  # first change all bottlers and distillers to array for better handling
  (site.posts.docs + site.collections['notes'].docs).each do |doc|
    doc.data["distillery"] = Array(doc["distillery"])
    doc.data["bottler"] = Array(doc["bottler"])
  end

  site.collections['distillery_infos'].docs.each do |doc|
    doc.data["title"] = doc.data["distillery"]
  end

  site.collections['bottler_infos'].docs.each do |doc|
    doc.data["title"] = doc.data["full_name"]
  end
  (site.collections['bottler_infos'].docs + site.collections['distillery_infos'].docs).each do |doc|
     doc.data["layout"] = "info"
  end

  distilleries = ((site.posts.docs + site.collections['distillery_infos'].docs + site.collections['notes'].docs)
    .map { |doc| Array(doc["distillery"]) }.flatten | []).sort
  distillery_infos = Hash[site.collections['distillery_infos'].docs.collect {
    |doc| [doc["distillery"], doc]
  }]
  distilleries.each do |distillery|
    raise "Missing distillery info for #{distillery}" unless distillery_infos.key?(distillery)
    raise "Missing region info for #{distillery}" \
      unless distillery_infos[distillery].data.key?("region")
    raise "Invalid region info for #{distillery}: #{distillery_infos[distillery]['region']}" \
      unless distillery_regions.include? distillery_infos[distillery]["region"]
    raise "Missing chinese name for #{distillery}" \
      unless distillery_infos[distillery].data.key?("chinese")
  end
  site.data["distillery_infos"] = distillery_infos
  site.data["distilleries"] = distilleries
  site.data["region_to_distilleries"] = distilleries.group_by {|d| distillery_infos[d]['region']}

  # INFO: META for bottlers
  bottlers = ((site.posts.docs + site.collections['bottler_infos'].docs + site.collections['notes'].docs)
    .map {|doc| Array(doc["bottler"])}.flatten | []).sort

  bottler_infos = Hash[site.collections['bottler_infos'].docs.collect {|doc| [doc["bottler"], doc]}]
  bottlers.each do |bottler|
    raise "Missing bottler info for #{bottler}" unless bottler_infos.key?(bottler)
    raise "Missing full name for #{bottler}" \
      unless bottler_infos[bottler].data.key?("full_name")
    raise "Missing chinese name for #{bottler}" \
      unless bottler_infos[bottler].data.key?("chinese")
  end
  site.data["bottlers"] = bottlers
  site.data["bottler_infos"] = bottler_infos


  hash = Hash.new { |h, key| h[key] = [] }
  (site.collections['notes'].docs + site.posts.docs).each do |p|
    p.data["categories"]&.each { |t| hash[t] << p }
  end
  site.data["all_categories"] = hash

  site.data["region_translate"] = {
    "Highland" => "高地",
    "Lowland" => "低地",
    "Speyside" => "斯贝赛",
    "Cambell Town" => "坎贝尔镇",
    "Islay" => "艾雷岛",
    "Islands" => "岛屿"
  }
end
