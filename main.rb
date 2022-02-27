require "http"

puts "-- Ruby ---------------------------------------"
puts "Ruby version: #{RUBY_VERSION}"
puts "HTTP version: #{HTTP::VERSION}"
puts "--- HTTP test ---------------------------------"
puts "https://httpbin.org/get: #{HTTP.get("http://httpbin.org/get", params: { hello: "world" }).status.code}"
