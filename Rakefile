require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("spec")
task default: :spec

namespace :docker do
  desc 'build docker'
  task :build, [:tag] do |t, args|
    sh "docker build -t webuilder240/ogp_parse_api:latest ."
  end

  desc 'push docker image for docker hub'
  task :push do
    sh "docker push webuilder240/ogp_parse_api:latest"
  end

  desc 'build and push docker image for docker hub'
  task :build_and_push do
    Rake::Task["docker:build"].invoke("latest")
    Rake::Task["docker:push"].invoke
  end

  desc 'deploy for dockerhub'
  task :deploy do
    Rake::Task["docker:build"].invoke("latest")
    Rake::Task["docker:push"].invoke
  end
end
