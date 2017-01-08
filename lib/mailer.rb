require 'mandrill'

module Mailer

  module_function

  def mandrill
    Mandrill::API.new($CONFIG['api_key'])
  end

  def send_email(to, options = {})
    message = {
      subject: $CONFIG['subject'],
      from_name: $CONFIG['from_alias'],
      text: options.map { |k, v| "#{k}: #{v}" }.join("\n"),
      to: [{ email: to, name:  options[:name] }],
      html: "<html>#{options.map { |k, v| "<strong>#{k}</strong>: #{v}" }.join('<br>')}</html>",
      from_email: $CONFIG['from']
    }
    mandrill.messages.send message
  end
end
