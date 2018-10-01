class ImportError < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.import_error.import_error_messages.subject
  #
  def import_error_messages(user,errors)
    @greeting = "Hi"
    @user = user
    @errors = errors
    mail to: @user.email, subject: "There were some errors when importing your data"
  end
end
