require 'jekyll'

task default: "deploy"

desc "Pull any changes from the remotely deployed site"
task :pull do
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git pull"
  end
end

desc "Build the site into the _site directory"
task build: [:pull] do
  config = Jekyll.configuration({ "source" => "./", "destination" => "./_site" })
  site = Jekyll::Site.new(config)
  Jekyll::Commands::Build.build site, config
end

desc "Build and deploy the site via the gh-pages branch"
task deploy: [:build] do
  Dir.chdir(File.dirname(__FILE__) + "/_site") do
    system "git add ."
    system "git commit -m 'Deployed at #{Time.now.iso8601}'"
    system "git push"
  end
end