describe IIPolicy::Chain do
  let(:user) do
    User.find(1)
  end

  let(:policy) do
    ChainUserPolicy.new(user: user)
  end

  it 'chains policies' do
    policy.call(:index?)
    expect(policy.context.chains).to eq(['A', 'B', 'MAIN'])
  end
end
