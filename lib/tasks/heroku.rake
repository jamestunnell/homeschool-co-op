namespace :heroku do
  desc "Configure Heroku application using ENV[APP_CONFIG_FILE]"
  task config: :environment do
    config_hash = YAML.load_file(APP_CONFIG_FILE)
    kv_pairs = config_hash.each.map {|k,v| "\"#{k}=#{v}\"" }
    `heroku config:set #{kv_pairs.join(" ")}`
  end
end
