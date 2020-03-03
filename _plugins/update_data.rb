# frozen_string_literal: true

require 'net/http'
require 'json'

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info 'Updating JSON Data: Blogs & Sites'

  # Download and parse the blogs data
  response = Net::HTTP.get(URI('https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json'))
  blogs = JSON.parse(response)

  # Count and sort the blogs in each category, case insensitive!
  blogs_count = 0
  blogs.each do |language|
    language['categories'].each do |category|
      category['sites'].sort_by! { |site_data| site_data['title'].delete_prefix('The ').downcase }
      blogs_count += category['sites'].count
    end
  end

  # Where are the files going to be written?
  blogs_json_path = File.join(site.source, '/_data/blogs.json')
  stats_json_path = File.join(site.source, '/_data/stats.json')

  # Ensure that path exists
  FileUtils.mkdir_p(File.dirname(blogs_json_path))

  # Write out the sorted blog data
  File.open(blogs_json_path, 'w') do |file|
    file.write(JSON.pretty_generate(blogs))
  end

  # Write out the stats data
  stats = { blogs_count: blogs_count }
  File.open(stats_json_path, 'w') do |file|
    file.write(JSON.pretty_generate(stats))
  end
end
