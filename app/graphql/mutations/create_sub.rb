class Mutations::CreateSub < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :city, String, required: true

  field :user, Types::UserType, null: false
  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(name:, email:, city:)
    user = User.new(name:, email:, city:)

    if user.save
      {
        user:,
        message: "Subscription added for #{user.email} on daily weather updates for #{user.city}",
        errors: []
      }
    else
      {
        user: nil,
        message: 'User already subscribed.'
        # errors: user.errors.full_messages
      }
    end
  end
end
