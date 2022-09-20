require 'clockwork'
require 'active_support/time'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(10.seconds, 'send.daily.weather') do
    
    User.all.each do |user|
      UserMailer.with(user:).subscribe.deliver_now
    end
  end
end
