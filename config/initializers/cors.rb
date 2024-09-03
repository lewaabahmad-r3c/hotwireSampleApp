Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Adjust this as needed for your frontend's origin

    # Apply CORS rules only for routes starting with /api
    resource '/api/*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: false # Set to true if you need to support cookies
  end
end
