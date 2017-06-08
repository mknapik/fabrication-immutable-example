# frozen_string_literal: true

require 'fabrication'
require_relative '../../lib/car'

Fabricator(:car) do
  mark 'Toyota'
  good false
  model 'Yaris'
  year 2016
  rest1 'rest1'
  opt1 'opt1'
  opt2 { 'opt2' }
  block { proc {} }
end
