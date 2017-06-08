# frozen_string_literal: true

class Car
  def initialize(mark, good = false, *args, model:, year: nil, **opts, &block)
    @mark = mark
    @model = model
    @good = good
    @year = year
    @rest = args
    @opts = opts
    yield if block
  end

  attr_reader :mark, :model, :year, :args, :opts
end
