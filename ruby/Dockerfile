FROM ruby:3.1

# -- Installations -----------------------------------------------------------
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

# -- Startup ------------------------------------------------------------------
COPY . .
CMD ["bundle", "exec", "ruby", "main.rb"]