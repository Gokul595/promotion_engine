class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  # Retrieve the current cart based on the session
  def current_cart
    Cart.find(session[:cart_id]) if session[:cart_id]
  end
end
