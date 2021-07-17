class ChainByMethodPolicy < IIPolicy::Base
  chain :chain_policies

  def chain_policies
    [Chains::APolicy]
  end
end
