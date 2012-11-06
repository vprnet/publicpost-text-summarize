require 'sinatra'
require 'summarize'

get '/summarize?*' do
  text = params[:text]
  
  #default
  ratio = 50
  if !params[:ratio].nil?
    ratio = params[:ratio].to_i
  end
  
  summed_text = text.summarize(:ratio => ratio)
  return "#{summed_text}"
end

get '/topics?*' do
  text = params[:text]
  topic_text = text.summarize(:topics => true)
  return "#{topic_text[1]}"
end