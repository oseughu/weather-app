module Util
  def self.convert_timezone(unixTime:, timezone:)
    Time.at(unixTime + timezone).gmtime.strftime('%-I:%M %p')
  end
  
  def self.get_weather(name:)
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{name}&appid=#{ENV['OPENWEATHERMAP_API_KEY']}"
    response = HTTParty.get(url)
    
    {
      name: response['name'],
      weather: response['weather'][0]['description'],
      longitude: response['coord']['lon'],
      latitude: response['coord']['lat'],
      sunrise: Util.convert_timezone(unixTime: response['sys']['sunrise'], timezone: response['timezone']),
      sunset: Util.convert_timezone(unixTime: response['sys']['sunset'], timezone: response['timezone'])
    }
  end
end
