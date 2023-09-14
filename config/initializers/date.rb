class Date
  def self.from_hash(hash)
    self.new(hash['year'] || 2000, hash['month'] || 1, hash['day'] || 1)
  end
end
