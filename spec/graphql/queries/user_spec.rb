require 'rails_helper'

RSpec.describe 'query get a single user' do
  it 'returns the user details' do
    response = WeatherAppSchema.execute(user_query, variables: { id: 1 })
    expect(response.dig('data', 'user', 'id')).to eq('1')
  end

  it 'returns an error if user does not exist' do
    expect { WeatherAppSchema.execute(user_query, variables: { id: 100 }) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

def user_query
  query = <<~GQL
    query User($id: ID!) {
      user(id: $id) {
        id
        name
        email
        city
      }
    }
  GQL
end
