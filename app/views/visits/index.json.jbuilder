json.array!(@visits) do |visit|
  json.extract! visit, :id, :index
  json.url visit_url(visit, format: :json)
end
