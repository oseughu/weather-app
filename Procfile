release: bin/rails db:migrate RAILS_ENV=production && clockwork clock.rb
web: bin/rails server -p ${PORT:-3000} -e $RAILS_ENV