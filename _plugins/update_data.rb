require "net/http"
require "json"

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Updating JSON Data: Blogs & Sites"

  # Download and parse the blogs data
  response = Net::HTTP.get(URI("https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json"))
  content = JSON.parse(response)

  # Sort the blogs in each category, case insensitive!
  content.each do |language|
    language["categories"].each do |category|
      category["sites"].sort_by! { |site| site["title"].downcase }
    end
  end

  # Write the local copy of the blogs data
  json_path = File.join(site.source, "/_data/")
  json_file = "content.json"
  FileUtils.mkdir_p(json_path)
    File.open("#{json_path}#{json_file}", "w") do |file|
    file.write(JSON.pretty_generate(content))
  end
end
