describe ItemsController, type: :request do
  context 'index' do
    it 'is authorized' do
      get items_path
      expect(response.code).to eq('200')
    end
  end

  context 'show' do
    it 'is authorized' do
      get item_path(id: 1)
      expect(response.code).to eq('200')
    end

    it 'is not authorized' do
      get item_path(id: 2)
      expect(response.code).to eq('403')
    end
  end
end
