require 'json'

class Words
  attr_accessor :limit

  def initialize(text, limit=5)
    raise ArgumentError unless text.respond_to?(:split)

    @text = text
    @limit = limit.to_i
    @stat = Hash.new(0)
  end

  def words
    @words ||= @text.strip.split /[\s\W]+/
  end

  def stat
    return @stat unless @stat.empty?

    words.each do |word|
      @stat[word] += 1
    end
    @stat = Hash[@stat.sort_by {|_key, value| -value}]
  end

  def to_json(options={})
    Hash[stat.first(limit)].to_json
  end
end
