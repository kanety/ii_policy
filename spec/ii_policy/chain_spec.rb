describe IIPolicy::Chain do
  let :current_user do
    User.find(1)
  end

  let :policy do
    ChainItemPolicy.new(user: current_user)
  end

  it 'chains policies' do
    policy.call(:index?)
    expect(policy.context.chains).to eq(['A', 'B', 'MAIN'])
  end
end
