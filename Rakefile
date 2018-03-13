require 'jekyll'

task default: "build"

desc "Pull any changes from the remotely deployed site"
task :pull do
  puts "=== Pulling from GitHub Pages ==="
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git pull"
  end
end

desc "Build the site into the _site directory"
task :build do
  puts "=== Building site ==="
  config = Jekyll.configuration({ "source" => "./", "destination" => "./_site" })
  site = Jekyll::Site.new(config)
  Jekyll::Commands::Build.build site, config
end

desc "Build and deploy the site via the gh-pages branch"
task deploy: [:pull, :build] do
  puts "=== Deploying to GitHub Pages ==="
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git add ."
    system "git commit -m 'Deployed at #{Time.now.iso8601}'"
    system "git push"
  end
end