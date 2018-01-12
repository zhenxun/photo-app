class MyRegistrationsController < Devise::RegistrationsController
  
  def create
    super
    if @user.persisted?
      AuthMailer.new_auth(@user).deliver_now
    end
  end
  
end