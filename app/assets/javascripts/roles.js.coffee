# root = exports ? this
# class root.Roles extends root.Singleton

#   manage_tweet_updater: (query)->
#     clearInterval(@update_interval)
#     @set_tweet_updater(query)
  
#   set_tweet_updater: (query)->
#     @update_interval = setInterval(()->
#         $.get('/roles/update_tweets', {query: query})
#       , 60000)
