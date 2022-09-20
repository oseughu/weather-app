require 'clockwork'
require './config/boot'
require './config/environment'
require 'active_support/time'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.day, 'send.daily.weather', at: '08:00') do
    User.all.each do |user|
      mail = UserMailer.with(user:).subscribe(user).deliver_later
      puts mail
    end
  end
end
