release: bundle exec rails db:migrate
web: bundle exec puma -C config/puma.rb
js: yarn build --watch
css: yarn build:css --watch
jobs: bin/jobs -c config/queue.yml
