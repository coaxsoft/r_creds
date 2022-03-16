RSpec.describe RCreds do
  it 'has a version number' do
    expect(RCreds::VERSION).not_to be_nil
  end

  context 'without Rails' do
    it 'raises NoRailsError' do
      expect { RCreds.fetch(:test, :credentials) }.to raise_error(RCreds::Fetcher::NoRailsError)
    end
  end
end
