class ContactMailer < ActionMailer::Base
  def send_email contact_form
    mail(:from => "#{contact_form.name} <#{contact_form.email}>",
         :to => ENV['contact_email'],
         :subject => 'Contact Form Response',
         :body => contact_form.message)
  end
end
