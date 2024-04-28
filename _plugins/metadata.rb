distillery_regions = ["Highland", "Lowland", "Speyside", "Cambell Town", "Islay", "Islands"]

# edit metadata
Jekyll::Hooks.register :site, :post_read do |site|
  # first change all bottlers and distillers to array for better handling
  (site.posts.docs + site.collections['notes'].docs).each do |doc|
    doc.data["distillery"] = Array(doc["distillery"])
    doc.data["bottler"] = Array(doc["bottler"])
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
  end
  site.data["distillery_infos"] = distillery_infos
  site.data["distilleries"] = distilleries
  site.data["region_to_distilleries"] = distilleries.group_by {|d| distillery_infos[d]['region']}

  # INFO: META for bottlers
  bottlers = ((site.posts.docs + site.collections['bottler_infos'].docs + site.collections['notes'].docs)
    .map {|doc| Array(doc["bottler"])}.flatten | []).sort

  bottler_infos = Hash[site.collections['bottler_infos'].docs.collect {|doc| [doc["bottler"], doc]}]
  bottlers.each do |bottler|
    raise "Missing distillery info for #{bottler}" unless bottler_infos.key?(bottler)
  end
  site.data["bottlers"] = bottlers
  site.data["bottler_infos"] = bottler_infos
end
