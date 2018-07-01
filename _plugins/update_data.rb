require "net/http"
require "json"

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Updating JSON Data: Blogs & Sites"

  # Download and parse the blogs data
  response = Net::HTTP.get(URI("https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json"))
  blogs = JSON.parse(response)

  # Sort the blogs in each category, case insensitive!
  blogs.each do |language|
    language["categories"].each do |category|
      category["sites"].sort_by! { |site| site["title"].downcase }
    end
  end

  # Write a local copy of the sorted blogs data
  blogs_json_path = File.join(site.source, "/_data/blogs.json")
  FileUtils.mkdir_p(blogs_json_path)
    File.open(blogs_json_path, "w") do |file|
    file.write(JSON.pretty_generate(content))
  end
end
