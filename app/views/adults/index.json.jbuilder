json.array!(@adults) do |adult|
  json.extract! adult, :id, :first, :last, :email
  json.url adult_url(adult, format: :json)
end
