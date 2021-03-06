require 'rails_helper'

partial_name = 'show/bit'
describe partial_name do
  let(:partial)   { "wallaby/resources/#{partial_name}.html.erb" }
  let(:value)     { '1' }
  let(:metadata)  { {} }

  before { render partial, value: value, metadata: metadata }

  it 'renders bit' do
    expect(rendered).to include "<code>#{value}</code>"
  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'renders null' do
      expect(rendered).to include view.null
    end
  end
end
