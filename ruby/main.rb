require "sinatra"
require "sinatra/json"
require "http"
require "json"

set :bind, "0.0.0.0"

get "/" do
  python_response = JSON.parse(HTTP.get("http://flask:#{ENV["PYTHON_PORT"] || 5000}/").body)
  json({
    ruby: {
      message: "Hello from Ruby!",
      version: RUBY_VERSION,
    },
    python: python_response,
  })
end
