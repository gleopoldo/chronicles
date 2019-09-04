module Chronicles
  class Mailer
    class << self
      def setup
        return if @loaded

        @loaded = true
        Mail::Configuration.instance.delivery_method(:smtp, {
          address: smtp_address,
          port: smtp_port,
          user_name: smtp_user,
          password: smtp_passwd,
          enable_starttls_auto: true,
          authentication: "plain"
        })
      end

      def smtp_address
        puts ENV["SMTP_ADDRESS"].to_s
        ENV["SMTP_ADDRESS"].to_s
      end

      def smtp_port
        ENV["SMTP_PORT"].to_s
      end

      def smtp_user
        ENV["SMTP_USER"].to_s
      end

      def smtp_passwd
        ENV["SMTP_PASSWORD"].to_s
      end
    end
  end
end
