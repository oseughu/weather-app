require 'rails_helper'

RSpec.describe 'mutation subscribe' do
  it 'subscribes them to daily weather updates and returns a success message.' do
    response = WeatherAppSchema.execute(subscribe_query)
    expect(response.dig('data', 'createSub', 'user')).not_to be_blank
  end

  it 'returns an error if user already exists.' do
    response = WeatherAppSchema.execute(subscriber_exists_query)
    expect(response.dig('data', 'createSub', 'user')).to be_nil
    expect(response.dig('data', 'createSub', 'message')).to eq('User already subscribed.')
  end
end

def subscribe_query
  query = <<~GQL
    mutation {
      createSub(input: {name: "James Bond", email: "doesnotexist@example.com", city: "Abuja"}){
        user {
          id
          name
          email
          city
        }
        message
      }
    }
  GQL
end

def subscriber_exists_query
  query = <<~GQL
    mutation {
      createSub(input: {name: "Test Account", email: "test@test.com", city: "Abuja"}){
        user {
          id
          name
          email
          city
        }
        message
      }
    }
  GQL
end

def user_payload
  { name: 'Test User', email: 'doesnotexist@example.com', city: 'Lagos' }
end
