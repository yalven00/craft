require 'open-uri'
require 'csv'

class YahooFinance
  FIELDS = {
    name: 'n',
    market_cap: 'j1',
    revenue: 's6',
    pe_ratio: 'r',
    shares_outstanding: 'j2',
    share_price: 'p',
    earning_per_share: 'e'
    # Net Income
    # Net Margin
  }

  def self.get_info(symbol = '')
    return {} if symbol.blank?
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{URI.escape(symbol)}&f=#{FIELDS.values.join('')}"
    conn = open(url)
    CSV.parse(conn.read, :headers => FIELDS.keys)
  end
end
