require 'rails_helper'

RSpec.describe 'query get all users' do
  it 'returns all the subscribed users' do
    response = WeatherAppSchema.execute(users_query)
    expect(response.dig('data', 'users')).not_to be_nil
  end
end

def users_query
  query = <<~GQL
    {
      users {
        id
        name
        email
        city
      }
    }
  GQL
end
