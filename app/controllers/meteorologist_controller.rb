require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @street_address_without_spaces = @street_address.gsub(" ","+")
    @urlSA = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}"

    @parsed_dataSA = JSON.parse(open(@urlSA).read)
    @latitudeSA = @parsed_dataSA["results"][0]["geometry"]["location"]["lat"]
    @longitudeSA = @parsed_dataSA["results"][0]["geometry"]["location"]["lng"]

    @urlLL = "https://api.darksky.net/forecast/536a17e7baa43cb09416f4827c77d010/#{@latitudeSA},#{@longitudeSA}"
    @parsed_dataLL = JSON.parse(open(@urlLL).read)

    @current_temperature = @parsed_dataLL["currently"]["temperature"]

    @current_summary = @parsed_dataLL["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_dataLL["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_dataLL["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_dataLL["daily"]["summary"]


    render("meteorologist/street_to_weather.html.erb")
  end
end
