RSpec.describe 'query get city weather info' do
  it 'returns the city and weather info' do
    response = WeatherAppSchema.execute(city_query, variables: { name: 'Lagos' })
    expect(response.dig('data', 'city', 'weather')).not_to be_nil
  end

  it 'returns an error if city does not exist' do
    expect { WeatherAppSchema.execute(city_query, variables: { name: 'abcd' }) }.to raise_error(NoMethodError)
  end
end

def city_query
  query = <<~GQL
    query City($name: String!) {
      city(name: $name) {
        name
        weather
        latitude
        longitude
        sunrise
        sunset
      }
    }
  GQL
end
