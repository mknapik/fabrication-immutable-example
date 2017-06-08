# frozen_string_literal: true

class Car
  # rubocop:disable Metrics/ParameterLists
  def initialize(mark, good = false, *args, model:, year: nil, **opts, &block)
    @mark = mark
    @model = model
    @good = good
    @year = year
    @rest = args
    @opts = opts
    yield if block
  end
  # rubocop:enable Metrics/ParameterLists

  attr_reader :mark, :model, :year, :args, :opts
end
