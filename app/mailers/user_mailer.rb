class UserMailer < ApplicationMailer
  def contact_form(form)
    @greeting = "Hi"

    mail to: "tedmlopez@gmail.com", subject: "noted contact form!"
  end
end
