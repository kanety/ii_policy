describe IIPolicy::Callbacks do
  let :current_user do
    User.find(1)
  end

  context 'before' do
    [Callbacks::BeforeAllPolicy, Callbacks::BeforeCallPolicy].each do |policy_klass|
      context policy_klass do
        let :policy do
          policy_klass.new(user: current_user)
        end

        it 'calls callback' do
          policy.allowed(:index?)
          expect(policy.instance_variable_get('@callback')).to eq('before')
        end
      end
    end
  end

  context 'after' do
    [Callbacks::AfterAllPolicy, Callbacks::AfterCallPolicy].each do |policy_klass|
      context policy_klass do
        let :policy do
          policy_klass.new(user: current_user)
        end

        it 'calls callback' do
          policy.allowed(:index?)
          expect(policy.instance_variable_get('@callback')).to eq('after')
        end
      end
    end
  end

  context 'around' do
    [Callbacks::AroundAllPolicy, Callbacks::AroundCallPolicy].each do |policy_klass|
      context policy_klass do
        let :policy do
          policy_klass.new(user: current_user)
        end

        it 'calls callback' do
          policy.allowed(:index?)
          expect(policy.instance_variable_get('@callback')).to eq('around')
        end
      end
    end
  end
end
