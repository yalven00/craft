# class RolesController < ApplicationController
#   def search
#     @values = params[:search].except(:keywords, :location).values

#     @tweets = find_tweets(@values.join(' AND '))
#     bing = Bing.new(ENV['BING_API_KEY'], 10, 'News')
#     @news = bing.search(@values.join(' '))

#     respond_to do |format|
#       format.js { render :search, layout: false }
#     end
#   end

#   def update_tweets
#     @tweets = find_tweets(params[:query])
#     respond_to do |format|
#       format.js { render :update_tweets, layout: false }
#     end
#   end

#   def find_tweets(query)
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV['TWITTER_API_KEY']
#       config.consumer_secret     = ENV['TWITTER_SECRET']
#     end

#     client.search(query, lang: "en")
#   end
# end
