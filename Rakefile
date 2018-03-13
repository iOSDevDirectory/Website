require 'jekyll'

task default: "build"

desc "Build the site into the _site directory"
task :build do
  puts "=== Building site ==="
  config = Jekyll.configuration({ "source" => "./", "destination" => "./_site" })
  site = Jekyll::Site.new(config)
  Jekyll::Commands::Build.build site, config
end

desc "Build and deploy the site via the gh-pages branch"
task :deploy do
  puts "=== Pulling remote changes ==="
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git pull"
  end

  # Build in production mode for analytics
  ENV["JEKYLL_ENV"] = "production"
  Rake::Task["build"].invoke

  puts "=== Deploying to GitHub Pages ==="
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git add ."
    system "git commit -m 'Deployed at #{Time.now.iso8601}'"
    system "git push"
  end
end