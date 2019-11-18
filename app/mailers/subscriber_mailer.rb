class SubscriberMailer < ApplicationMailer
	def new_post(subscriber, post)
		@subscriber = subscriber
		@post = Post.last(1)
    mail to: subscriber.email, subject: "nowy post", from: 'pienczyn.d@gmail.com'
	end
end
