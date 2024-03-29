require 'json'
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

post '/summarize?*' do
  text = params[:text]
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

post '/topics?*' do
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
  encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => '',        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }
  text = text.encode Encoding.find('ASCII'), encoding_options
  terms = TermExtract.extract(text, :types => :nn)
  unless terms.nil?
    terms.keys.sort_by {|key, value| value}.reverse
  end
  return "#{terms.to_json}"  
end

post '/terms?*' do
  text = params[:text]
  
  encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => '',        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }
  text = text.encode Encoding.find('ASCII'), encoding_options
  terms = TermExtract.extract(text, :types => :nn)
  unless terms.nil?
    terms.keys.sort_by {|key, value| value}.reverse
  end
  return "#{terms.to_json}"  
end
