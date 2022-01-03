describe IIPolicy::Coactors do
  let :current_user do
    User.find(1)
  end

  let :policy do
    CoactiveItemPolicy.new(user: current_user)
  end

  it 'lookups coactors' do
    expect(policy.coactors).to eq([Coactors::APolicy, Coactors::BPolicy])
  end

  it 'calls coactors' do
    policy.allowed(:index?)
    expect(policy.context.coactors).to eq(['A', 'B', 'MAIN'])
  end
end
