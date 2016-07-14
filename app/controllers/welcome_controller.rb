class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index; end

  def auth_dash 
  	@ledgers = current_user.ledgers.last(2).reverse
  end

end
