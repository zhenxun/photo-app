# Preview all emails at http://localhost:3000/rails/mailers/auth_mailer
class AuthMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/auth_mailer/new_auth
  def new_auth
    AuthMailer.new_auth
  end

end
