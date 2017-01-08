require 'sinatra'
require 'json'
require_relative './lib/mailer'

post '/' do
  content_type :json
  response = Mailer.send_email(
    $CONFIG['to'], JSON.parse(request.body.read.to_s)
  )
  return response.to_json
end
