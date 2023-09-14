module IndustriesHelper

#   def format_tweet(text, hashtags)
#     tags = text.scan(/\#\w+/)
#     usernames = text.scan(/\@\w+/)
#     links = text.scan(/(https?:\/\/)?([\w\.]+\.)([a-z]{2,6}\.?)(\/[\w\.]*)*\/?/)

#     (tags + usernames).each do |item|
#       content = content_tag(:a, item, href: '#')
#       text = text.sub(item, content)
#     end

#     links.each do |item|
#       item = item.join('')
#       content = content_tag(:a, item, href: item)
#       text = text.sub(item, content)
#     end

#     text.html_safe
#   end
end
