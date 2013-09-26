
require 'sinatra'
require 'json'

require './app/words'

get '/' do
  erb :about
end

post '/words_count' do
  Words.new(params[:text], params[:limit]).to_json
end
