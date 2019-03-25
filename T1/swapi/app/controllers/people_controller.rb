require 'httparty'
class PeopleController < ApplicationController

    def all
        response = HTTParty.get("https://swapi.co/api/people")
        @people = []
        done = false
        while !done
          response["results"].each do |r|
            person = Hash.new
            person["name"] = r["name"]
            person["height"] = r["height"]
            person["mass"] = r["mass"]
            person["hair_color"] = r["hair_color"]
            person["skin_color"] = r["skin_color"]
            person["eye_color"] = r["eye_color"]
            person["birth_year"] = r["birth_year"]
            person["gender"] = r["gender"]
            person["homeworld"] = r["homeworld"]
            person["films"] = r["films"]
            person["starships"] = r["starships"]
            person["url"] = r["url"]
            @people.push(person)
          end
          next_url = response["next"]
          if next_url
            response = HTTParty.get(next_url)
          else
            done = true
          end
        end
        @people
    end

    def specific
      url = params[:url]
      response = HTTParty.get(url)
      @person = Hash.new
      @person["name"] = response["name"] 
      @person["height"] = response["height"] 
      @person["mass"] = response["mass"] 
      @person["hair_color"] = response["hair_color"] 
      @person["skin_color"] = response["skin_color"] 
      @person["eye_color"] = response["eye_color"] 
      @person["birth_year"] = response["birth_year"] 
      @person["gender"] = response["gender"] 
      homeworld = Hash.new
      homeworld["name"] = (HTTParty.get(response["homeworld"]))["name"]
      homeworld["url"] = response["homeworld"] 
      @person["homeworld"] = homeworld
      films_urls = response["films"]
      films = []
      films_urls.each do |url|
        char = Hash.new
        char["title"] = (HTTParty.get(url))["title"]
        char["url"] = url
        films.push(char)
      end
      @person["films"] = films
      starships_urls = response["starships"]
      starships = []
      starships_urls.each do |url|
        char = Hash.new
        char["name"] = (HTTParty.get(url))["name"]
        char["url"] = url
        starships.push(char)
      end
      @person["starships"] = starships 
      @person["url"] = response["url"] 
      @person
    end

end
