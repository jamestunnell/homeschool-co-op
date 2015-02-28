class ContactMailer < ActionMailer::Base
  def send_email contact_form
    mail(contact_form.headers)
  end
end
