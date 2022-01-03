describe IIPolicy::Base do
  before do
    @traversal = IIPolicy.config.traversal
  end

  after do
    IIPolicy.config.traversal = @traversal
  end

  let :current_user do
    User.find(1)
  end

  context 'preorder' do
    before do
      IIPolicy.config.traversal = :preorder
    end

    let :policy do
      CoactiveItemPolicy.new(user: current_user)
    end

    it 'traverses preorder' do
      policy.allowed(:index?)
      expect(policy.context.called).to eq(['MAIN', 'A', 'B'])
    end
  end

  context 'postorder' do
    before do
      IIPolicy.config.traversal = :postorder
    end

    let :policy do
      CoactiveItemPolicy.new(user: current_user)
    end

    it 'traverses postorder' do
      policy.allowed(:index?)
      expect(policy.context.called).to eq(['A', 'B', 'MAIN'])
    end
  end

  context 'inorder' do
    before do
      IIPolicy.config.traversal = :inorder
    end

    let :policy do
      CoactiveItemPolicy.new(user: current_user)
    end

    it 'traverses inorder' do
      policy.allowed(:index?)
      expect(policy.context.called).to eq(['A', 'MAIN', 'B'])
    end
  end
end
