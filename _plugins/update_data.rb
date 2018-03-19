require "net/http"
require "json"

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Updating JSON Data: Downloading from iOSDevDirectory repository"

  # Download the data and parse into JSON
  uri = URI("https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/content.json")
  response = Net::HTTP.get(uri)
  content = JSON.parse(response)

  # Sort the data, case insensitive!
  content.each do |language|
    language["categories"].each do |category|
      category["sites"].sort_by! { |site| site["title"].downcase }
    end
  end

  # Write the JSON as part of the site before generation starts
  json_path = File.join(site.source, "/_data/")
  json_file = "content.json"
  FileUtils.mkdir_p(json_path)
    File.open("#{json_path}#{json_file}", "w") do |file|
    file.write(JSON.pretty_generate(content))
  end
end
