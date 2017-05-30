json.extract! server, :id, :login, :pass, :domain, :host, :created_at, :updated_at
json.url server_url(server, format: :json)
