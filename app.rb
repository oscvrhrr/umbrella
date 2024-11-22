require "dotenv/load"
require "http"
require "json"

street = "trinity"
street_type = "dr"
city = "novato"

raw_response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{street}%20#{"street_type"}%20#{city}&key=#{ENV.fetch("GMAPS_KEY")}")
parsed_response = JSON.parse(raw_response)

coordinates = parsed_response["results"][0]["geometry"]["location"]
lat = coordinates["lat"]
lng = coordinates["lng"]

raw_response_weather = HTTP.get("https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}")
parsed_response_weather = JSON.parse(raw_response_weather)
current_forecast = parsed_response_weather["currently"]["temperature"]

pp "the current temperature in #{street} #{street_type} #{city} is #{current_forecast} fahrenheit "
