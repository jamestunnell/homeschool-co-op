class MailgunMailer < ActionMailer::Base
  def send_email msg_params
    mg_api_key = ENV['mailgun_api_key']
    mg_domain = ENV['mailgun_domain']
    mg_client = Mailgun::Client.new mg_api_key
    mg_client.send_message mg_domain, msg_params
  end
  
  def send_contact_email(contact_form)
    send_email(:from => contact_form.email,
               :to => ENV['contact_email'],
               :subject => 'Contact Form Response',
               :text => contact_form.message)
  end
end
