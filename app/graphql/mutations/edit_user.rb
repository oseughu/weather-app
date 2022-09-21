class Mutations::EditUser < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :city, String, required: true

  field :user, Types::UserType, null: false
  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(name:, email:, city:)
    user = User.find_by(email:)

    if user
      updated_user = user.update(name:, email:, city:)
      {
        user: updated_user,
        message: "User profile updated for #{email}.",
        errors: []
      }
    else
      {
        user: nil,
        message: 'User not found.',
        errors: user.errors.full_messages
      }
    end
  end
end
