RSpec.describe RCreds do
  it 'has a version number' do
    expect(RCreds::VERSION).to eq('1.0.2')
  end

  context 'without Rails' do
    it 'raises NoRailsError' do
      expect { RCreds.fetch(:test, :credentials) }.to raise_error(RCreds::Fetcher::NoRailsError)
    end
  end
end
