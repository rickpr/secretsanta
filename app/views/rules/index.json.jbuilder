json.array!(@rules) do |rule|
  json.extract! rule, :id, :gifter, :recipient, :santa_id
  json.url rule_url(rule, format: :json)
end
