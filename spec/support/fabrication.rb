# frozen_string_literal: true

require 'fabrication'
require_relative 'word_sequencer'
require_relative 'fabrication/generators/immutable_generator'

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix = '.'
  config.sequence_start = 1
  config.generators << Fabrication::Generator::ImmutableGenerator
end
