# class IndustriesController < ApplicationController
#   def search
#     @industry = params[:search][:industry]

#     @tweets = find_tweets(@industry)

#     bing = Bing.new(ENV['BING_API_KEY'], 10, 'News')
#     @news = bing.search(@industry)

#     respond_to do |format|
#       format.js { render :search, layout: false }
#     end
#   end

#   def areas
#     if params[:term].present?
#       render json: Industry.find_area(params[:term])
#     end
#   end

#   def bls_industries
#     @result = Industry.search(params[:search]) if params[:search].present?
#     respond_to do |format|
#       format.html
#       format.js { render :bls_industries, layout: false }
#     end
#   end

#   def update_tweets
#     @tweets = find_tweets(params[:industry])
#     respond_to do |format|
#       format.js { render :update_tweets, layout: false }
#     end
#   end

#   def find_tweets(query = '')
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV['TWITTER_API_KEY']
#       config.consumer_secret     = ENV['TWITTER_SECRET']
#     end

#     client.search(query + '-rt', lang: "en")
#   end
# end
