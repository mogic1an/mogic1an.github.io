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
      caskdef = {
        "American Oak" => "美国橡木桶",
        "Rejuvenated American Oak" => "恢复活力的美国橡木桶",
        "Rejuvenated American Oak Hogsheads" => "多个恢复活力的美国橡木桶",
        "Rivesaltes" => "Rivesaltes甜红酒桶",
        "Sauternes" => "苏玳桶",
        "Port" => "波特桶",
        "Armagnac" => "雅文邑桶",
        "Bourbon" => "波本桶",
        "Malbec" => "马尔贝克红酒桶",
        "Oloroso" => "Oloroso雪莉桶",
        "PX" => "PX雪莉桶",
        "Ex-Pedro Ximenez Cask" => "PX雪莉桶",
        "PX Hogshead" => "PX猪头桶",
        "Palo Cortado Hogshead" => "Palo Cortado猪头桶",
        "Butt" => "Butt桶",
        "Rum Quarter Cask" => "朗姆四分之一桶",
        "French Oak" => "法国橡木桶",
        "French Oak Wine" => "法国橡木红酒桶",
        "French Oak Barrique" => "法国橡木Barrique桶",
        "Refill Butt" => "再填Butt桶",
        "Refill Barrel" => "再填Barrel桶",
        "Refill Sherry Butt" => "再填雪莉Butt桶",
        "Refill Sherry Hogshead" => "再填雪莉猪头桶",
        "Refill Sherry Butts" => "多个再填雪莉Butt桶",
        "Refill Sherry Casks" => "多个再填雪莉桶",
        "Refill Sherry" => "再填雪莉桶",
        "Refill Hogshead" => "再填猪头桶",
        "Refill Bourbon Hogshead" => "再填波本猪头桶",
        "Refill American Oak Hogshead" => "再填美国橡木猪头桶",
        "Refill American Oak Hogsheads" => "多个再填美国橡木猪头桶",
        "Bourbon Hogshead" => "波本猪头桶",
        "2nd Fill Barrel" => "第二次装填Barrel桶",
        "1st Fill American Oak Barrel" => "初填美国橡木Barrel桶",
        "American Oak Sherry Casks" => "多个美国橡木雪莉桶",
        "1st Fill Bourbon" => "初填波本桶",
        "1st Fill Bourbon Barrel" => "初填波本Barrel桶",
        "1st Fill Bourbon Hogshead" => "初填波本猪头桶",
        "Bourbon Barrel" => "波本Barrel桶",
        "1st Fill PX Hogshead" => "初填PX猪头桶",
        "1st Fill PX Butt" => "初填PX Butt桶",
        "1st Fill Bourbon Hogsheads" => "多个初填波本猪头桶",
        "1st Fill Sauternes Hogshead" => "初填苏玳猪头桶",
        "1st Fill Sherry Butt Finish" => "初填雪莉Butt桶收尾",
        "1st Fill Sherry Hogshead" => "初填雪莉猪头桶",
        "1st Fill Oloroso Butt" => "初填Oloroso雪莉Butt桶",
        "Oloroso Butt" => "Oloroso雪莉Butt桶",
        "1st Fill Oloroso" => "初填Oloroso雪莉桶",
        "1st Fill Amarone" => "初填Amarone红酒桶",
        "2nd Fill Amarone" => "第二次装填Amarone红酒桶",
        "2nd Fill French Oak" => "第二次装填法国橡木桶",
        "2nd Fill ex-Bodega" => "第二次装填雪莉酒厂用桶",
        "Bodega European Oak Butts" => "多个雪莉酒厂用的欧洲橡木Butt桶",
        "Refill European Oak Butt" => "欧洲橡木Butt桶",
        "Sherry" => "雪莉桶",
        "Amarone Finish" => "Amarone红酒桶收尾",
        "Barrel" => "Barrel桶",
        "Sherry Butt" => "雪莉Butt桶",
        "4 Refill Hogsheads" => "四个再填猪头桶",
        "Hogshead" => "猪头桶",
        "2 Hogsheads" => "两个猪头桶",
        "Moscatel Finish" => "莫斯卡托桶收尾",
        "Sherry Casks" => "多个雪莉桶",
        "Fino Sherry Casks" => "多个菲诺雪莉桶",
        "White Oak Casks" => "多个白色橡木桶",
        "New Oak Cask (Char No.3)" => "新橡木桶(烘烤度3)",
        "Oloroso Sherry Puncheon" => "Oloroso雪莉邦穹桶",
        "Oloroso Sherry Butt" => "Oloroso雪莉Butt桶",
        "Rhone Syrah Wine Casks" => "多个隆纳河谷希拉红酒桶",
        "Palo Cortado Sherry Butt" => "Palo Cortado雪莉Butt桶",
      }
      raise "Missing cask translation for #{cask}" unless caskdef.key?(cask)
      caskdef[cask]
    end
  end
end

Liquid::Template.register_filter(Jekyll::ExtendedDateFilter)
Liquid::Template.register_filter(Jekyll::TranslationFilter)
