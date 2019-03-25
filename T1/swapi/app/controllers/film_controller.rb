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
      char_urls = response["characters"]
      characters = []
      char_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        characters.push(char)
      end
      @film["characters"] = characters
      planets_urls = response["planets"]
      planets = []
      planets_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        planets.push(char)
      end
      @film["planets"] = planets
      starships_urls = response["starships"]
      starships = []
      starships_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        starships.push(char)
      end
      @film["starships"] = starships
      @film["url"] = response["url"] 
      @film
    end

end
