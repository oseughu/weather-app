require 'rails_helper'

RSpec.describe 'mutation subscribe' do
  it 'subscribes them to daily weather updates and returns a success message.' do
    user = { name: 'James Bond', email: 'jamesbond@gmail.com', city: 'London' }
    message = "Subscription added for #{user[:email]} on daily weather updates for #{user[:city]}"
    response = WeatherAppSchema.execute(subscribe_query, variables: user)
    expect(response.dig('data', 'createSub', 'user', 'name')).to eq(user[:name])
    expect(response.dig('data', 'createSub', 'message')).to eq(message)
  end

  it 'returns an error if user already exists.' do
    user = { name: 'Test User', email: 'test@test.com', city: 'Lagos' }
    response = WeatherAppSchema.execute(subscribe_query, variables: user)
    expect(response.dig('data', 'createSub', 'user')).to be_nil
  end
end

def subscribe_query
  query = <<~GQL
    mutation CreateSub($name: String!, $email: String!, $city: String!) {
      createSub(input: {name: $name, email: $email, city: $city}){
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

# The test above is pretty straightforward. We are testing the subscribe mutation.
# We are testing that the user is subscribed to daily weather updates and that the user is returned.
# We are also testing that the user is not subscribed if they already exist.
