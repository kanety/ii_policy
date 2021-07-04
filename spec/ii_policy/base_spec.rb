describe IIPolicy::Base do
  context 'properties' do
    let :policy do
      UserPolicy.new(user: User.find(1))
    end

    it 'gets context' do
      expect(policy.context.user).to be_kind_of(User)
    end
  end

  context 'methods' do
    let :policy do
      UserPolicy.new(user: User.find(1))
    end

    it 'calls allowed' do
      expect(policy.allowed(:index?)).to eq(true)
    end

    it 'gets policy of other object' do
      expect(policy.policy(User.find(1))).to be_kind_of(UserPolicy)
    end
  end
end
