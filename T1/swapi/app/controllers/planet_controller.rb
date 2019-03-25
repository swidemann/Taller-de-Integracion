class PlanetController < ApplicationController

    def all
        response = HTTParty.get("https://swapi.co/api/planets")
        @planets = []
        done = false
        while !done
          response["results"].each do |r|
            planet = Hash.new
            planet["name"] = r["name"] 
            planet["rotation_period"] = r["rotation_period"] 
            planet["orbital_period"] = r["orbital_period"] 
            planet["diameter"] = r["diameter"] 
            planet["climate"] = r["climate"] 
            planet["gravity"] = r["gravity"] 
            planet["terrain"] = r["terrain"] 
            planet["surface_water"] = r["surface_water"] 
            planet["population"] = r["population"] 
            planet["residents"] = r["residents"] 
            planet["films"] = r["films"] 
            planet["url"] = r["url"] 
            @planets.push(planet)
          end
          next_url = response["next"]
          if next_url
            response = HTTParty.get(next_url)
          else
            done = true
          end
        end
        @planets
    end

    def specific
      url = params[:url]
      response = HTTParty.get(url)
      @planet = Hash.new
      @planet["name"] = response["name"] 
      @planet["rotation_period"] = response["rotation_period"] 
      @planet["orbital_period"] = response["orbital_period"] 
      @planet["diameter"] = response["diameter"] 
      @planet["climate"] = response["climate"] 
      @planet["gravity"] = response["gravity"] 
      @planet["terrain"] = response["terrain"] 
      @planet["surface_water"] = response["surface_water"] 
      @planet["population"] = response["population"] 
      @planet["residents"] = response["residents"] 
      residents_urls = response["residents"]
      residents = []
      residents_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        residents.push(char)
      end
      @planet["residents"] = residents
      films_urls = response["films"]
      films = []
      films_urls.each do |url|
        char = Hash.new
        char["title"] = (HTTParty.get(url))["title"]
        char["url"] = url
        films.push(char)
      end
      @planet["films"] = films
      @planet["url"] = response["url"]
      @planet
    end

end
