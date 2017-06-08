# frozen_string_literal: true

require 'delegate'

class WordSequencer < SimpleDelegator
  def initialize(length)
    range = (('a' * length)..('z' * length))
    alphabet_size = 26
    enumerator = Enumerator.new(alphabet_size**length) do |yielder|
      range.lazy.each do |seq|
        yielder << seq
      end
    end

    super(enumerator)
  end

  module ClassMethods
    def chars(length)
      words_sequencer(length).next
    rescue StopIteration
      reset_characters_sequence!(length)
      chars(length)
    end

    private

    def reset_characters_sequence!(length)
      words_sequencers[length] = nil
    end

    def words_sequencer(length)
      words_sequencers[length]
    end

    def words_sequencers
      @words_sequencer ||= Hash.new do |h, k|
        h[k] = WordSequencer.new(k)
      end
    end
  end

  class << self
    include ClassMethods
  end
end
