class Reindeer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reindeer.pick.subject
  #
  def pick(gifter: nil, recipient: nil)
    #This instance variable is used to carry over to the template
    @recipient = recipient
    mail subject: "Your Secret Santa results are in!",
    to: gifter,
    from_name: "Secret Santa",
    from: "secretsanta@fdisk.co"
  end

end
