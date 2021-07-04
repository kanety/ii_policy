describe ChainUsersController, type: :request do
  context 'index' do
    it 'is authorized' do
      get chain_users_path
      expect(response.code).to eq('200')
    end
  end

  context 'show' do
    it 'is authorized' do
      get chain_user_path(id: 1)
      expect(response.code).to eq('200')
    end

    it 'is not authorized' do
      get chain_user_path(id: 2)
      expect(response.code).to eq('403')
    end
  end
end
