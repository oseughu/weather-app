class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.subscribe.subject
  #
  default from: 'ose.ughu@outlook.com'
  layout 'mailer'
  def subscribe(user)
    @user = user

    def convert_time(unixTime:, timezone:)
      Time.at(unixTime + timezone).gmtime.strftime('%-I:%M %p')
    end

    base_url = 'https://api.openweathermap.org/data/2.5'
    url = "#{base_url}/weather?q=#{@user.city}&appid=#{ENV['OPENWEATHERMAP_API_KEY']}"
    response = HTTParty.get(url)

    @name = response['name']
    @weather = response['weather'][0]['description']
    @longitude = response['coord']['lon']
    @latitude = response['coord']['lat']
    @sunrise = convert_time(unixTime: response['sys']['sunrise'], timezone: response['timezone'])
    @sunset = convert_time(unixTime: response['sys']['sunset'], timezone: response['timezone'])

    mail to: @user.email, subject: 'Your daily weather update'
  end
end
