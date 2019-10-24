class DeviseMailer < Devise::Mailer

  def confirmation_instructions(record, token, opts={})
    opts[:from] = 'akshay@rubyinrails.com'
    opts[:to] = 'no_reply@rubyinrails.com'
    super
  end
  
end