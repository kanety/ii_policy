describe IIPolicy::Chain do
  let :current_user do
    User.find(1)
  end

  context 'chain by class' do
    let :policy do
      ChainItemPolicy.new(user: current_user)
    end

    it 'lookups chained policies' do
      expect(policy.lookup).to eq([Chains::APolicy, Chains::BPolicy])
    end

    it 'calls chained policies' do
      policy.call(:index?)
      expect(policy.context.chains).to eq(['A', 'B', 'MAIN'])
    end
  end

  context 'chain by method' do
    let :policy do
      ChainByMethodPolicy.new(user: current_user)
    end

    it 'lookups chained policies' do
      expect(policy.lookup).to eq([Chains::APolicy])
    end
  end

  context 'chain by block' do
    let :policy do
      ChainByBlockPolicy.new(user: current_user)
    end

    it 'lookups chained policies' do
      expect(policy.lookup).to eq([Chains::APolicy])
    end
  end
end
