json.(@medium, :id, :file, :url)
json.likes @medium.count_likes
json.liked @current_user.liked?(@medium)
json.tags @medium.tags do |tag|
  json.(tag, :id, :name)
end

if @current_user.author? || @current_user.admin?
  json.admin true
end
