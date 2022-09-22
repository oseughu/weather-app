module Types
  class QueryType < Types::BaseObject
    # All Users
    field :users, [Types::UserType], null: false

    # A single user
    field :user, Types::UserType, null: false do
      argument :email, String, required: true
    end

    # Get current weather info of city
    field :city, Types::CityType, null: false do
      argument :name, String, required: true
    end

    def users
      User.all
    end

    def user(email:)
      User.find(email)
    end

    def city(name:)
      Util.get_weather(name:)
    end
  end
end
