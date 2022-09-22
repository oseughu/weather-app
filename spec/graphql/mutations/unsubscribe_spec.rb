require 'rails_helper'

RSpec.describe 'mutation unsubscribe' do
  it 'unsubscribes them from daily weather updates and returns a successful deletion message.' do
    user = { name: 'Test User', email: 'test@test.com', city: 'Lagos' }
    response = WeatherAppSchema.execute(unsubscribe_query, variables: user)
    expect(response.dig('data', 'deleteSub', 'user', 'name')).to eq(user[:name])
    expect(response.dig('data', 'deleteSub', 'message')).to eq("Subscription deleted for #{user[:email]}.")
  end

  it 'returns an error if user does not exist.' do
    user = { name: 'Test User Wey No Dey DB', email: 'test@inodey.com', city: 'Lagos' }
    response = WeatherAppSchema.execute(unsubscribe_query, variables: user)
    expect(response.dig('data', 'deleteSub', 'user')).to be_nil
  end
end

def unsubscribe_query
  query = <<~GQL
    mutation DeleteSub($email: String!) {
      deleteSub(input: {email: $email}){
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
