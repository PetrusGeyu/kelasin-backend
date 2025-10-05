
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # Allow requests from your client running on http://localhost:3000
  allow do
    origins 'http://localhost:4000' # 👈 Set this to your frontend's address

    resource '*', # You can narrow this down (e.g., to '/api/*')
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head] # Allow all necessary methods
  end

  # 💡 Optional: If you deploy your app later, you can add the production origin
  # allow do
  #   origins 'https://www.yourproductionapp.com'
  #   resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
  # end
end