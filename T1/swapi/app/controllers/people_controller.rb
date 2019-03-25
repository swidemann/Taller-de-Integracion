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
      @person["eyes_color"] = response["eyes_color"] 
      @person["birth_year"] = response["birth_year"] 
      @person["gender"] = response["gender"] 
      @person["homeworld"] = response["homeworld"] 
      @person["films"] = response["films"] 
      @person["starships"] = response["starships"] 
      @person["url"] = response["url"] 
      @person
    end

end
