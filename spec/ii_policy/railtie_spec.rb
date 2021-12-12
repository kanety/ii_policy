describe IIPolicy::Railtie do
  it 'clears cache when reloaded' do
    IIPolicy::Lookup.call(Item)
    expect(IIPolicy::Lookup.cache.size).not_to eq(0)

    Rails.application.reloader.reload!
    expect(IIPolicy::Lookup.cache.size).to eq(0)

    IIPolicy::Lookup.call(Item)
    expect(IIPolicy::Lookup.cache.size).not_to eq(0)
  end
end
