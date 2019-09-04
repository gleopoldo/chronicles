require 'mail'
require 'chronicles/mailer'

module Chronicles
  # someone to deliver your history to other people.
  # They are the ancient messengers.
  #
  # Hope that they find someone that can read...
  # In the Middle Ages, just few people could read/write
  #
  # Who'll remember you if you can't share you deeds?
  class Herald
    def send_message!(bard)
      Mailer.setup

      mail = Mail.new do
        from "hglocaweb@gmail.com"
        to bard.destination
        subject bard.lyrics_title
        body bard.compose
      end

      mail.deliver
    end
  end
end
