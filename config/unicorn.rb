worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

# pid File.expand_path('../../tmp/unicorn.pid', __FILE__)

listen 8080, tcp_nopush: true
timeout 30
