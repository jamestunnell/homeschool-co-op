json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :abbrev
  json.url subject_url(subject, format: :json)
end
