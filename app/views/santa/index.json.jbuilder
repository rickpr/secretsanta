json.array!(@santa) do |santum|
  json.extract! santum, :id, :name, :email, :group_id
  json.url santum_url(santum, format: :json)
end
