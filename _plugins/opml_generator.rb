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
                xml.title "#{category['title']} (#{language['title']}) from the iOS Dev Directory (http://iosdevdirectory.com)"
                xml.dateCreated Time.now.strftime('%a, %d %b %Y %H:%M:%S %z')
              end
              xml.body do
                category['sites'].each do |site_data|
                  if site_data['author'].nil? || site_data['author'].empty?
                    xml.outline(type: 'rss',
                                text: site_data['title'],
                                xmlUrl: site_data['feed_url'],
                                htmlUrl: site_data['site_url'])
                  else
                    xml.outline(type: 'rss', text: site_data['title'],
                                xmlUrl: site_data['feed_url'],
                                htmlUrl: site_data['site_url'],
                                description: "By #{site_data['author']}")
                  end
                end
              end
            end
          end

          # Generate one OPML file per category
          opml_path = File.join(site.dest, "/opml/#{language['language']}/")
          opml_file = "#{category['slug']}.opml"
          FileUtils.mkdir_p(opml_path)
          File.open("#{opml_path}#{opml_file}", 'w') do |file|
            file.write(builder.to_xml)
          end

          # All OPML files must also be part of the site
          site.pages << Jekyll::Page.new(site, site.dest, opml_path, opml_file)
        end
      end
    end
  end
end
