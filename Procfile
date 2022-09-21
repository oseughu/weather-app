web: bin/rails server -p ${PORT:-3000} -e $RAILS_ENV
worker: bundle exec clockwork clock.rb
release: bin/rails db:migrate