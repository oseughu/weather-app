require 'rails_helper'

RSpec.describe 'mutation edit user' do
  it 'updates the user details and returns a success message.' do
    user_payload = { name: 'Test User', email: 'test@test.com', city: 'Prague' }
    message = "User profile updated for #{user_payload[:email]}."
    user = User.find_by(email: user_payload[:email])

    response = WeatherAppSchema.execute(edit_user_query, variables: user_payload) if user
    expect(response.dig('data', 'editUser', 'user', 'name')).to eq(user[:name])
    expect(response.dig('data', 'editUser', 'message')).to eq(message)
  end

  it 'returns an error if user does not exist.' do
    user_payload = { name: 'James Bond', email: 'jamesbond@gmail.com', city: 'London' }
    user = User.find_by(email: user_payload[:email])
    response = WeatherAppSchema.execute(edit_user_query, variables: user_payload)
    expect(response.dig('data', 'editUser', 'user')).to be_nil
  end
end

def edit_user_query
  query = <<~GQL
    mutation EditUser($name: String!, $email: String!, $city: String!) {
      editUser(input: {name: $name, email: $email, city: $city}){
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
