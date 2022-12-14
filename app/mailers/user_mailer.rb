class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:

  default from: 'ose.ughu@outlook.com'
  def subscribe(user)
    @user = user

    result = Util.get_weather(name: @user[:city])

    @name = result[:name]
    @weather = result[:weather]
    @longitude = result[:longitude]
    @latitude = result[:latitude]
    @sunrise = result[:sunrise]
    @sunset = result[:sunset]

    mail to: @user[:email], subject: 'Your daily weather update'
  end
end
