# frozen_string_literal: true

module Jekyll
  module OrdinalDateFilter
    def ordinal_date(date)
      date = Date.parse(date.to_s)
      day = date.day
      suffix = if (11..13).include?(day % 100)
                 "th"
               else
                 case day % 10
                 when 1 then "st"
                 when 2 then "nd"
                 when 3 then "rd"
                 else "th"
                 end
               end
      "#{day}#{suffix} #{date.strftime('%B %Y')}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::OrdinalDateFilter)
