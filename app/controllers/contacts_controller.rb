class ContactsController <ApplicationController
  # GET request to?contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
 # POST request /contacts
  def create
    #Mass assingment of form fields into contacts obejects
    @contact = Contact.new(contact_params)
    #Save the contact object to the database
    if @contact.save
      #Store form fields via paramaters, into variebles
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variebles into Contact Mailer
      #Email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      #Store succes message in flash hash
      # and redirect to the new action.
      flash[:success] = "Message sent."
     redirect_to new_contact_path
  else
    # If contact objest doesn't save 
    # and redirect to new action
     flash[:danger] = @contact.errors.full_messages.join(", ")
     redirect_to new_contact_path
    end
  end
  private
  # To collect data from we need to use
  #strong parameters and whitelist the form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end