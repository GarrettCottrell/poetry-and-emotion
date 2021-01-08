class SearchController < ApplicationController
  def index
    author = params[:author]
    conn = Faraday.new(url: "https://poetrydb.org")

   response = conn.get("/author/#{author}")
   @json = JSON.parse(response.body, symbolize_names: true)

@tones = []
@json.first(10).each do |poem_lines|
  conn = Faraday.new("https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/ace39cb0-2e50-4289-9ce5-32aa07d1afbf/v3/tone?version=2017-09-21") do |faraday|
    faraday.basic_auth('apikey', 'w_giJH3es6PKFJmVmssKz3WOI1UjYsAUDkorpnsRXzjz')
   end
   response = conn.get("/v3/tone?version=2017-09-21&text=#{URI.encode(poem_lines[:lines].join(" "))}")
   json = JSON.parse(response.body, symbolize_names: true)
   @tone = json[:document_tone][:tones][0][:tone_name]
   poem_lines[:tone] = @tone
    end
    
  end
end


  #  text = params[:Submit_Text]
  #   conn = Faraday.new("https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/ace39cb0-2e50-4289-9ce5-32aa07d1afbf/v3/tone?version=2017-09-21") do |faraday|
  #   faraday.basic_auth('apikey', 'w_giJH3es6PKFJmVmssKz3WOI1UjYsAUDkorpnsRXzjz')
  #  end
  #  response = conn.get("/v3/tone?version=2017-09-21&text=How is everyone")
  #  json = JSON.parse(response.body, symbolize_names: true)
  #   @tone = json[:tone]
  #  end