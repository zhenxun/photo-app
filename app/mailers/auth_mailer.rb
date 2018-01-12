class AuthMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auth_mailer.new_auth.subject
  #
  def new_auth(user)
    @user = user
    #mail to: @user.email, subject: "Your account validation email"
  end
end
