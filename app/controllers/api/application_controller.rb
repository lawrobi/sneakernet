class Api::ApplicationController < ApplicationController
  before_filter :custom_authenticate_user!,
                :only => [:create, :update, :destroy]

  def custom_authenticate_user!
    head :unauthorized unless user_signed_in?
  end
end
