require 'rails_helper'

RSpec.describe 'query get a single user' do
  it 'returns the user details' do
    response = WeatherAppSchema.execute(user_query, variables: { email: 'test@test.com' })
    expect(response.dig('data', 'user')).not_to be_nil
  end

  it 'returns an error if user does not exist' do
    response = WeatherAppSchema.execute(user_query, variables: { id: 100 })
    expect(response.dig('data', 'user')).to be_nil
  end
end

def user_query
  query = <<~GQL
    query User($email: String!) {
      user(email: $email) {
        id
        name
        email
        city
      }
    }
  GQL
end
