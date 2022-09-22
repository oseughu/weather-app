class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  en.user_mailer.subscribe.subject = 'Your daily weather update'
  default from: 'ose.ughu@outlook.com'
  layout 'mailer'
  def subscribe(user)
    @user = user

    result = Util.get_weather(name: @user[:city])

    @name = result[:name]
    @weather = result[:weather].first[:description]
    @longitude = result.dig(:coord, :lon)
    @latitude = result.dig(:coord, :lat)
    @sunrise = Util.convert_timezone(unixTime: result.dig(:sys, :sunrise), timezone: result[:timezone])
    @sunset = Util.convert_timezone(unixTime: result.dig(:sys, :sunset), timezone: result[:timezone])

    mail to: @user[:email]
  end
end
