describe IIPolicy::Callbacks do
  let :current_user do
    User.find(1)
  end

  context 'before' do
    let :policy do
      Callbacks::BeforePolicy.new(user: current_user)
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('before')
    end
  end

  context 'after' do
    let :policy do
      Callbacks::AfterPolicy.new(user: current_user)
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('after')
    end
  end

  context 'around' do
    let :policy do
      Callbacks::AroundPolicy.new(user: current_user)
    end

    it 'calls callback' do
      policy.call(:index?)
      expect(policy.instance_variable_get('@callback')).to eq('around')
    end
  end
end
