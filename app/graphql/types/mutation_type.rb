module Types
  class MutationType < Types::BaseObject
    field :create_sub, mutation: Mutations::CreateSub
    field :delete_sub, mutation: Mutations::DeleteSub
  end
end
