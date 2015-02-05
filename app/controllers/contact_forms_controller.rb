class ContactFormsController < ApplicationController
  def create
    begin
      @contact_form = ContactForm.new(contact_form_params)
      @contact_form.request = request
      
      if @contact_form.deliver
        redirect_to request.referer, notice: 'Thank you for your message!'
      else
        redirect_to request.referer, alert: 'Message could not be delivered.'
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
  
  private
    def contact_form_params
      params.require(:contact_form).permit(:name, :email, :message, :nickname)
    end
end
