class ContactFormsController < ApplicationController
  def create
    begin
      @contact_form = ContactForm.new(contact_form_params)
      @contact_form.request = request
      
      ContactMailer.send_email(@contact_form).deliver_now
      redirect_to request.referer, notice: 'Thank you for your message!'
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
  
  private
    def contact_form_params
      params.require(:contact_form).permit(:name, :email, :message, :nickname)
    end
end
