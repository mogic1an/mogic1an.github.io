module Jekyll
  module ExtendedDateFilter
    def date_to_chinese(date)
      date = time(date)
      "#{date.year}年#{date.month}月#{date.day}日"
    end
  end
end

Liquid::Template.register_filter(Jekyll::ExtendedDateFilter)
