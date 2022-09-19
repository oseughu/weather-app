module Types
  class QueryType < Types::BaseObject
    # All Users
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    # A single user
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    # Get current weather info of city
    field :city, Types::CityType, null: false do
      argument :name, String, required: true
    end
  end
end
