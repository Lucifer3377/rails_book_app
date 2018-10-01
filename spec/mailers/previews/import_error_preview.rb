# Preview all emails at http://localhost:3000/rails/mailers/import_error
class ImportErrorPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/import_error/import_error_messages
  def import_error_messages
    ImportError.import_error_messages
  end

end
