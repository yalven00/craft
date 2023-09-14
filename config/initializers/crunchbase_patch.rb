module Crunchbase
  class Search
    def self.find(query, params={})
      j = API.search(query)
      s = Search.new(query, j)
    end
  end

  class API
    def self.search(query, params={})
      require "cgi"
      uri = CB_URL + "search.js?query=#{CGI.escape(query)}&page=1&field=name&entity=company"
      get_json_response(uri)
    end
  end

  class Person
    def self.find_photo(permalink)
      json = JSON.load(open("http://api.crunchbase.com/v/2/person/#{permalink}?user_key=#{ENV['CRUNCHBASE_API_KEY_V2']}"))
      photo = json['data']['relationships']['primary_image']
    end
  end
end
