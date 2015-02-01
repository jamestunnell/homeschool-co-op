json.array!(@children) do |child|
  json.extract! child, :id, :first, :last, :birth_date
  json.url child_url(child, format: :json)
end
