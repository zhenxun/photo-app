class MyRegistrationsController < Devise::RegistrationsController
  
  def create
    #super
    build_resource(sign_up_params)
    
    resource.class.transaction do
      resource.save
      
      yield resource if block_given?
      if resource.persisted?
        @payment = Payment.new(email: params["user"]["email"], token: params["token"], user_id: resource.id)
        
        flash[:error] = "Please check registration errors" unless @payment.valid?
        
        begin
          @payment.process_payment
          @payment.save
          
#           if @user.persisted? and @payment.valid? and @payment.save?
#             AuthMailer.new_auth(@user).deliver_now
#           end
          
#           if @payment.valid?
#             puts 'send mail'
#             AuthMailer.new_auth(@user).deliver_now
#           end
          
        rescue Exception => e
          @user.skip_confirmation!
          flash[:error] = e.message
          resource.destroy
          puts 'Payment failed'
          render :new and return
          
        end
        
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
        
      else
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource             
       end
    end
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:payment)
  end
  
end