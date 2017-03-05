json.array! @media do |medium|
  json.(medium, :id, :file, :url, :album, :type, :created_at, :visible, :upload)
  json.updated_at medium.updated_at.strftime('%d/%m/%Y - %H:%M:%S')
end
