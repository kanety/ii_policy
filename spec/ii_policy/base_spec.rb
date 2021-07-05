describe IIPolicy::Base do
  let :current_user do
    User.find(1)
  end

  let :current_item do
    Item.find(1)
  end

  context 'properties' do
    let :policy do
      ItemPolicy.new(user: current_user, item: current_item)
    end

    it 'gets context' do
      expect(policy.context.user).to be_kind_of(User)
    end
  end

  context 'methods' do
    let :policy do
      ItemPolicy.new(user: current_user, item: current_item)
    end

    it 'calls allowed' do
      expect(policy.allowed(:index?)).to eq(true)
    end

    it 'gets policy of other object' do
      expect(policy.policy(current_item)).to be_kind_of(ItemPolicy)
    end
  end
end
