json.array!(@photos) do |photo|
  json.extract! photo, :id, :file_name, :file_path, :user_id_id
  json.url photo_url(photo, format: :json)
end
