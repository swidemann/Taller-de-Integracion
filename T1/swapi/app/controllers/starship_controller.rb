class StarshipController < ApplicationController

    def all
        response = HTTParty.get("https://swapi.co/api/starships")
        @starships = []
        done = false
        while !done
          response["results"].each do |r|
            starship = Hash.new
            starship["name"] = r["name"] 
            starship["model"] = r["model"] 
            starship["manufacturer"] = r["manufacturer"] 
            starship["cost_in_credits"] = r["cost_in_credits"] 
            starship["length"] = r["length"] 
            starship["max_atmosphering_speed"] = r["max_atmosphering_speed"] 
            starship["crew"] = r["crew"] 
            starship["passengers"] = r["passengers"] 
            starship["cargo_capacity"] = r["cargo_capacity"] 
            starship["consumables"] = r["consumables"] 
            starship["hyperdrive_rating"] = r["hyperdrive_rating"] 
            starship["MGLT"] = r["MGLT"]
            starship["starship_class"] = r["starship_class"]
            starship["pilots"] = r["pilots"]
            starship["films"] = r["films"]
            starship["url"] = r["url"]
            @starships.push(starship)
          end
          next_url = response["next"]
          if next_url
            response = HTTParty.get(next_url)
          else
            done = true
          end
        end
        @starships
    end

    def specific
      url = params[:url]
      response = HTTParty.get(url)
      @starship = Hash.new
      @starship["name"] = response["name"] 
      @starship["model"] = response["model"] 
      @starship["manufacturer"] = response["manufacturer"] 
      @starship["cost_in_credits"] = response["cost_in_credits"] 
      @starship["length"] = response["length"] 
      @starship["max_atmosphering_speed"] = response["max_atmosphering_speed"] 
      @starship["crew"] = response["crew"] 
      @starship["passengers"] = response["passengers"] 
      @starship["cargo_capacity"] = response["cargo_capacity"] 
      @starship["consumables"] = response["consumables"] 
      @starship["hyperdrive_rating"] = response["hyperdrive_rating"] 
      @starship["MGLT"] = response["MGLT"]
      @starship["starship_class"] = response["starship_class"]
      pilots_urls = response["pilots"]
      pilots = []
      pilots_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        pilots.push(char)
      end
      @starship["pilots"] = pilots
      films_urls = response["films"]
      films = []
      films_urls.each do |url|
        char = Hash.new
        char["title"] = (HTTParty.get(url))["title"]
        char["url"] = url
        films.push(char)
      end
      @starship["films"] = films
      @starship["url"] = response["url"]
      @starship
    end

end
