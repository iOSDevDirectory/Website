require "net/http"
require "json"

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Updating JSON Data: Downloading from iOSDevDirectory repository"

  # Download the data and parse into JSON
  uri = URI("https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/sites.json")
  response = Net::HTTP.get(uri)
  categories = JSON.parse(response)

  # Sort the data, case insensitive!
  categories.each do |category|
    category["sites"].sort_by! { |site| site["title"].downcase }
  end

  # Write the JSON as part of the site before generation starts
  json_path = File.join(site.source, "/_data/")
  json_file = "categories.json"
  FileUtils.mkdir_p(json_path)
  File.open("#{json_path}#{json_file}", "w") do |file|
    file.write(JSON.pretty_generate(categories))
  end
end
