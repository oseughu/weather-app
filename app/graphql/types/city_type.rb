# frozen_string_literal: true

module Types
  class CityType < Types::BaseObject
    field :name, String
    field :weather, String
    field :latitude, Float
    field :longitude, Float
    field :sunrise, String
    field :sunset, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
