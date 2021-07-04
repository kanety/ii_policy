describe IIPolicy::Callbacks do
  context 'before' do
    let :policy do
      Callbacks::BeforePolicy.new(user: User.find(1))
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('before')
    end
  end

  context 'after' do
    let :policy do
      Callbacks::AfterPolicy.new(user: User.find(1))
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('after')
    end
  end

  context 'around' do
    let :policy do
      Callbacks::AroundPolicy.new(user: User.find(1))
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('around')
    end
  end
end
