# frozen_string_literal: true

require 'json'

module Jekyll
  class SearchGenerator < Generator
    safe true

    def generate(site)
      store = []
      site.data['blogs'].each do |language|
        language['categories'].each do |category|
          category['sites'].each do |site_data|
            store << {
              id: site_data['id'],
              title: site_data['title'],
              author: site_data['author'].to_s,
              site_url: site_data['site_url']
            }
          end
        end
      end

      page = PageWithoutAFile.new(site, site.source, '', 'search.json')
      page.content = JSON.generate(store)
      page.data['layout'] = nil
      site.pages << page
    end
  end
end
