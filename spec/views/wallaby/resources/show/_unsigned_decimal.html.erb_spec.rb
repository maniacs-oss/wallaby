require 'rails_helper'

partial_name = 'show/unsigned_decimal'
describe partial_name do
  let(:partial)   { "wallaby/resources/#{partial_name}.html.erb" }
  let(:value)     { BigDecimal.new(42)**13 / 10**20 }
  let(:metadata)  { {} }

  before { render partial, value: value, metadata: metadata }

  it 'renders the unsigned_decimal' do
    expect(rendered).to include value.to_s
  end

  context 'when value is 0' do
    let(:value) { BigDecimal.new 0 }

    it 'renders the unsigned_decimal' do
      expect(rendered).to include value.to_s
    end
  end

  context 'when value is nil' do
    let(:value) { nil }

    it 'renders null' do
      expect(rendered).to include view.null
    end
  end
end
