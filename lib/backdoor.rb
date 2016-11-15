require 'hanami/mailer'
Dir["#{ __dir__ }/backdoor/**/*.rb"].each { |file| require_relative file }

Hanami::Mailer.configure do
  root "#{ __dir__ }/backdoor/mailers"

  # See http://hanamirb.org/guides/mailers/delivery
  delivery do
    development :test
    test        :test
    # production :smtp, address: ENV['SMTP_PORT'], port: 1025
  end
end.load!
