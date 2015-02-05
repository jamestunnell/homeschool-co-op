namespace :heroku do
  desc "Configure Heroku application using config/application.yml"
  task config: :environment do
    config_hash = YAML.load_file("#{Rails.root}/config/application.yml")
    kv_pairs = config_hash.each.map {|k,v| "\"#{k}=#{v}\"" }
    `heroku config:set #{kv_pairs.join(" ")}`
  end
end
