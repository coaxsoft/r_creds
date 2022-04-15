# frozen_string_literal: true

RSpec.describe RCreds do
  it 'returns a proper version' do
    expect(RCreds::VERSION).to be_a(String)
  end

  context 'without Rails' do
    it 'raises NoRailsError' do
      expect { described_class.fetch(:test, :credentials) }.to raise_error(RCreds::Fetcher::NoRailsError)
    end
  end

  describe 'config' do
    it 'provide block' do
      described_class.config do |c|
        expect(c).to eq(described_class)
      end
    end

    context 'with arguments' do
      let(:fake_class) { class_double(described_class) }

      it 'override environment_first' do
        allow(fake_class).to receive(:environment_first=).with(true)
        fake_class.environment_first = true
      end

      it 'override allow_nil_value' do
        allow(fake_class).to receive(:allow_nil_value=).with(true)
        fake_class.allow_nil_value = true
      end
    end
  end
end
