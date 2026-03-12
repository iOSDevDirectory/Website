# frozen_string_literal: true

require 'nokogiri'

module Jekyll
  class OPMLGenerator < Generator
    safe true

    def generate(site)
      site.data['blogs'].each do |language|
        language['categories'].each do |category|
          # Build the OPML for this category
          builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
            xml.opml(version: '2.0') do
              xml.head do
                xml.title "#{category['title']} (#{language['title']}) from the iOS Dev Directory (https://iosdevdirectory.com)"
                xml.dateCreated Time.now.strftime('%a, %d %b %Y %H:%M:%S %z')
              end
              xml.body do
                category['sites'].each do |site_data|
                  attrs = {
                    type: 'rss',
                    text: site_data['title'],
                    xmlUrl: site_data['feed_url'],
                    htmlUrl: site_data['site_url']
                  }
                  attrs[:description] = "By #{site_data['author']}" unless site_data['author'].to_s.empty?
                  xml.outline(**attrs)
                end
              end
            end
          end

          # Generate one OPML file per category
          opml_dir = "opml/#{language['language']}"
          opml_file = "#{category['slug']}.opml"
          page = PageWithoutAFile.new(site, site.source, opml_dir, opml_file)
          page.content = builder.to_xml
          page.data['layout'] = nil
          site.pages << page
        end
      end
    end
  end
end
