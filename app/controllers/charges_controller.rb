class ChargesController < ApplicationController

  def create
    @user = current_user
    #Creates a Stripe Customer object, for associating with the charge.
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  # Payment being made
  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: 9_99,
    description: "Upgrade to Premium Membership - #{current_user.email}",
    currency: 'usd'
  )

  @user.update_attributes(role: 'premium')
  @user.role = 'premium'
  @user.save
  flash[:notice] = "Thanks for the payment, #{current_user.email}! With your premium account you can now create and edit private wikis."
  redirect_to root_path

  # Stripe will send back CardErrors, with friendly messages when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end
end
