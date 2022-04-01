class WelcomeController < ApplicationController
  def index
    # redis = Redis.new(host: "redis", port: 6379)
    redis = Redis.new(host: "db-redis-nyc1-92923-do-user-11220077-0.b.db.ondigitalocean.com", port: 25061)

    redis.incr "page hits"

    @page_hits = redis.get("page hits")
  end
end
