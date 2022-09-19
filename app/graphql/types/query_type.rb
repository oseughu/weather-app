module Types
  class QueryType < Types::BaseObject
    # All Users
    field :users, [Types::UserType], null: false

    # A single user
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    # Get current weather info of city
    field :city, Types::CityType, null: false do
      argument :name, String, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end
    
    def convert_time(unixTime:, timezone:)
      Time.at(unixTime).in_time_zone(timezone).strftime('%-I:%M %p')
    end

    def city(name:)
      url = "https://api.openweathermap.org/data/2.5/weather?q=#{name}&appid=#{ENV['openweathermap_key']}"
      response = HTTParty.get(url)

      {
        name: response['name'],
        weather: response['weather'][0]['description'],
        longitude: response['coord']['lon'],
        latitude: response['coord']['lat'],
        sunrise: convert_time(unixTime: response['sys']['sunrise'], timezone: response['timezone']),
        sunset: convert_time(unixTime: response['sys']['sunset'], timezone: response['timezone'])
      }
    end
  end
end
