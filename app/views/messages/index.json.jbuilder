json.array!(@messages) do |message|
  json.extract! message, :channel_id, :body, :created_at, :updated_at
  json.url channel_message_url(@channel, message, format: :json)
end
