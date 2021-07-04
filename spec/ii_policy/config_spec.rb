describe IIPolicy::Config do
  context 'configure' do
    before do
      IIPolicy.configure do |config|
        config.lookup_cache = false
      end
    end

    after do
      IIPolicy.configure do |config|
        config.lookup_cache = true
      end
    end

    it 'gets and sets' do
      expect(IIPolicy::Config.lookup_cache).to eq(false)
    end
  end
end
