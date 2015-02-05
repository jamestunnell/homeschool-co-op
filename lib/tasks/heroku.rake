require 'open3'

def heroku_cmd_line(cmd)
  Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
    while line = stderr.gets
      puts line
    end
  end
end

namespace :heroku do
  desc "Configure Heroku application using ENV[APP_CONFIG_FILE]"
  task config: :environment do
    config_hash = YAML.load_file(APP_CONFIG_FILE)
    kv_pairs = config_hash.each.map {|k,v| "\"#{k}=#{v}\"" }
    heroku_cmd_line("heroku config:set #{kv_pairs.join(" ")}")
  end
  
  task deploy: :environment do
    heroku_cmd_line('git push heroku master')
  end
end
