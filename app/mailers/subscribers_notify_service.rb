class SubscribersNotifyService < ApplicationMailer

  def new_post(subscriber, post)
    @subscriber = subscriber
    @post = post
    mail to: subscriber.email, subject: "Nowy Post", from: 'pienczyn.d@gmail.com'
  end
end
