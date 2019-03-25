require 'httparty'
class FilmController < ApplicationController
    
    def all
        response = HTTParty.get("https://swapi.co/api/films")
        @films = []
        done = false
        while !done
          response["results"].each do |r|
            film = Hash.new
            film["title"] = r["title"]
            film["episode_id"] = r["episode_id"]
            film["opening_crawl"] = r["opening_crawl"]
            film["director"] = r["director"]
            film["producer"] = r["producer"]
            film["release_date"] = r["release_date"]
            film["url"] = r["url"]
            @films.push(film)
          end
          next_url = response["next"]
          if next_url
            response = HTTParty.get(next_url)
          else
            done = true
          end
        end
        @films
    end
    
    def specific
      url = params[:url]
      response = HTTParty.get(url)
      @film = Hash.new
      @film["title"] = response["title"] 
      @film["episode_id"] = response["episode_id"] 
      @film["opening_crawl"] = response["opening_crawl"] 
      @film["director"] = response["director"] 
      @film["producer"] = response["producer"] 
      @film["release_date"] = response["release_date"] 
      @film["characters"] = response["characters"] 
      @film["planets"] = response["planets"] 
      @film["starships"] = response["starships"] 
      @film["url"] = response["url"] 
      @film
    end

end
