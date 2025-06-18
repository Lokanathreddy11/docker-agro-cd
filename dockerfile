# Use official Ruby image as base
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client && \
    npm install -g yarn

# Set working directory
WORKDIR /myapp

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
