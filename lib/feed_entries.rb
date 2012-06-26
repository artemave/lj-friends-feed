class FeedEntries < Array
  def initialize(entries = [])
    validate(entries)
    self.concat entries
  end

  private

  def validate(entries)
    unless entries.all? {|e| e.is_a? Entry}
      raise 'This collection is for Entry instances only'
    end
  end
end
