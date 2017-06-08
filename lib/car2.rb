# frozen_string_literal: true

class Car2
  def initialize(mark, model:, year: nil, **opts)
    @mark = mark
    @model = model
    @year = year
    @opts = opts
  end

  attr_reader :mark, :model, :year, :args, :opts
end
