json.array!(@comments) do |comment|
  json.extract! comment, :poll_id, :comment, :rating
  json.url comment_url(comment, format: :json)
end
