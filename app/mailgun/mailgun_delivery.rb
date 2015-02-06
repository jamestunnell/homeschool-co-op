class MailgunDelivery
  def initialize onearg
    mg_api_key = ENV['mailgun_api_key']
    @mg_domain = ENV['mailgun_domain']
    @mg_client = Mailgun::Client.new mg_api_key
  end
  
  def deliver!(mail)
    msg_params = {
      :from => mail.from,
      :to => mail.to,
      :subject => mail.subject,
    }
    if mail.content_type =~ /^text\/html.*/
      msg_params[:html] = mail.body
    else
      msg_params[:text] = mail.body
    end
    
    res = @mg_client.send_message @mg_domain, msg_params
    puts res.to_h
  end
end
