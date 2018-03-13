require "nokogiri"

module Jekyll
  class OPMLGenerator < Generator
    safe true

    def generate(site)
      site.data["categories"].each do |category|
        # Build the OPML for this category
        builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
          xml.opml(version: "2.0") do
            xml.head do
              xml.title "#{category["title"]} from the iOS Dev Directory (http://iosdevdirectory.com)"
              xml.dateCreated Time.now.strftime("%a, %d %b %Y %H:%M:%S %z")
            end
            xml.body do
              category["sites"].each do |site|
                if site["author"].nil? || site["author"].length < 1 then
                  xml.outline(type: "rss", text: site["title"], xmlUrl: site["feed_url"], htmlUrl: site["site_url"])
                else
                  xml.outline(type: "rss", text: site["title"], xmlUrl: site["feed_url"], htmlUrl: site["site_url"], description: "By #{site["author"]}")
                end
              end
            end
          end
        end

        # Generate one OPML file per category
        opml_path = File.join(site.dest, "/opml/")
        opml_file = "#{category["slug"]}.opml"
        FileUtils.mkdir_p(opml_path)
        File.open("#{opml_path}#{opml_file}", "w") do |file|
          file.write(builder.to_xml)
        end

        # All OPML files must also be part of the site
        site.pages << Jekyll::Page.new(site, site.dest, opml_path, opml_file)
      end
    end
  end
end
