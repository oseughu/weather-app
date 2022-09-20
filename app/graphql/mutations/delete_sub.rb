class Mutations::DeleteSub < Mutations::BaseMutation
  argument :email, String, required: true
  
  field :user, Types::UserType, null: false
  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(email:)
    user = User.find_by(email: email)
    city = user.city
    
    if user
     user.destroy
      {
        user: user,
        message: "Subscription deleted for #{email}.",
        errors: []
      }
    else
      {
        user: nil,
        message: "No user found with email #{email}",
        errors: user.errors.full_messages
      }
    end
  end
end