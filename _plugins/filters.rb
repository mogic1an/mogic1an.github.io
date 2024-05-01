module Jekyll
  module ExtendedDateFilter
    def date_to_chinese(date)
      date = time(date)
      "#{date.year}年#{date.month}月#{date.day}日"
    end
  end
  module TranslationFilter
    def region_to_chinese(region)
      {
        "Highland" => "高地",
        "Lowland" => "低地",
        "Speyside" => "斯贝赛",
        "Cambell Town" => "坎贝尔镇",
        "Islay" => "艾雷岛",
        "Islands" => "岛屿"
      }[region]
    end
    def cask_to_chinese(cask)
      {
        "American Oak" => "美国橡木桶",
        "Bourbon" => "波本桶",
        "Refill Bourbon Hogshead" => "重填波本猪头桶",
      }[cask]
    end
  end
end

Liquid::Template.register_filter(Jekyll::ExtendedDateFilter)
Liquid::Template.register_filter(Jekyll::TranslationFilter)
