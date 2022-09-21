require 'clockwork'
require './config/boot'
require './config/environment'
require 'active_support/time'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(2.hours, 'send.daily.weather') do
    User.all.each do |user|
      UserMailer.with(user:).subscribe(user).deliver_now
    end
  end
end
