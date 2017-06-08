# frozen_string_literal: true

# frozen_string_literal: true.
require_relative '../../lib/car'
require_relative '../../lib/car2'

RSpec.describe 'fabrication' do
  describe 'car' do
    subject { Fabricate(:car, mark: mark, model: model) }

    let(:mark) { 'Ford' }
    let(:model) { 'Focus' }

    it { expect(subject.mark).to eq(mark) }
    it { expect(subject.model).to eq(model) }
  end

  describe 'car2' do
    subject { Fabricate(:car, mark: mark, model: model) }

    let(:mark) { 'Ford' }
    let(:model) { 'Focus' }

    it { expect(subject.mark).to eq(mark) }
    it { expect(subject.model).to eq(model) }
  end
end
