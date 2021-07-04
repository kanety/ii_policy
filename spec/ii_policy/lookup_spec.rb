describe IIPolicy::Lookup, type: :request do
  it 'lookups from model' do
    expect(IIPolicy::Base.lookup(User)).to eq(UserPolicy)
  end

  it 'lookups from controller' do
    expect(IIPolicy::Base.lookup(UsersController)).to eq(UserPolicy)
  end

  it 'returns nil if model does not find' do
    expect(IIPolicy::Base.lookup(Lookups::Unknown)).to eq(nil)
  end

  context 'inherited' do
    it 'lookups from model' do
      expect(IIPolicy::Base.lookup(Lookups::User)).to eq(Lookups::UserPolicy)
    end

    it 'lookups from model of superclass' do
      expect(IIPolicy::Base.lookup(Lookups::SharedUser)).to eq(UserPolicy)
    end
  end
end
