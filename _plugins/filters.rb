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
        "Islands" => "岛屿",
        "Ireland" => "爱尔兰"
      }[region]
    end
    def cask_to_chinese(cask)
      {
        "American Oak" => "美国橡木桶",
        "Rivesaltes" => "Rivesaltes甜红酒桶",
        "Bourbon" => "波本桶",
        "Oloroso" => "Oloroso雪莉桶",
        "PX" => "PX雪莉桶",
        "Butt" => "Butt桶",
        "Rum Quarter Cask" => "朗姆四分之一桶",
        "French Oak Barrique" => "法国橡木红酒桶",
        "Refill Butt" => "再填Butt桶",
        "Refill Hogshead" => "再填猪头桶",
        "Refill Bourbon Hogshead" => "再填波本猪头桶",
        "Refill American Oak Hogshead" => "再填美国橡木猪头桶",
        "Bourbon Hogshead" => "波本猪头桶",
        "2nd Fill Barrel" => "第二次装填Barrel桶",
        "1st Fill Bourbon Barrel" => "初填波本Barrel桶",
        "1st Fill Sherry Butt Finish" => "初填雪莉Butt桶收尾",
        "4 Refill Hogheads" => "四个再填猪头桶",
        "Hogshead" => "猪头桶",
        "2 Hogsheads" => "两个猪头桶",
        "Moscatel Finish" => "莫斯卡托桶收尾",

      }[cask]
    end
  end
end

Liquid::Template.register_filter(Jekyll::ExtendedDateFilter)
Liquid::Template.register_filter(Jekyll::TranslationFilter)
