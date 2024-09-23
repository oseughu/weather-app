module Types
  class MutationType < Types::BaseObject
    field :create_sub, mutation: Mutations::CreateSub
    field :delete_sub, mutation: Mutations::DeleteSub
    field :edit_user, mutation: Mutations::EditUser
  end
end
