describe IIPolicy::Lookup do
  context 'from model' do
    let :klass do
      Item
    end

    it 'lookups policy' do
      expect(IIPolicy::Base.lookup(klass)).to eq(ItemPolicy)
    end
  end

  context 'from controller' do
    let :klass do
      ItemsController
    end

    it 'lookups policy' do
      expect(IIPolicy::Base.lookup(klass)).to eq(ItemPolicy)
    end
  end

  context 'from unknown model' do
    let :klass do
      Lookups::Unknown
    end

    it 'returns nil if model does not find' do
      expect(IIPolicy::Base.lookup(klass)).to eq(nil)
    end
  end

  context 'from inherited model' do
    let :klass do
      Lookups::Item
    end

    it 'lookups policy' do
      expect(IIPolicy::Base.lookup(klass)).to eq(Lookups::ItemPolicy)
    end
  end

  context 'from superclass of inherited model' do
    let :klass do
      Lookups::SharedItem
    end

    it 'lookups policy' do
      expect(IIPolicy::Base.lookup(klass)).to eq(ItemPolicy)
    end
  end
end
