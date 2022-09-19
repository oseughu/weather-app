class WeatherController < ApplicationController
  def index
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=lagos&appid=#{ENV['openweathermap_key']}")
    data = JSON.parse(response.body)

    if response.code == 200
      city = City.new
      city.name = data['name']
      city.latitude = data['coord']['lat']
      city.longitude = data['coord']['lon']
      city.sunrise = Time.at(data['sys']['sunrise'])
      city.sunset = Time.at(data['sys']['sunset'])
      city.save
    end
  end
end

# https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
