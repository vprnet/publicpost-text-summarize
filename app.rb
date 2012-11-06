require 'sinatra'
require 'summarize'
require 'term-extract'

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
  ratio = 50
  if !params[:ratio].nil?
    ratio = params[:ratio].to_i
  end
  topic_text = text.summarize(:topics => true, :ratio => ratio)
  return "#{topic_text[1]}"
end

get '/terms?*' do
  text = params[:text]  
  terms = TermExtract.extract(text)

  return "#{terms.keys}"
end
