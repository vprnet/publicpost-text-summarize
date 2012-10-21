require 'sinatra'
require 'yomu'
require 'open-uri'

get '/extract?*' do
  url = URI::encode(params[:url])
  yomu = Yomu.new url
  yomu.text
end