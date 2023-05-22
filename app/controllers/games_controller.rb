require 'open-uri'

class GamesController < ApplicationController

  ALPHABET = ('A'..'Z').to_a

  def score

    @answer = params[:answer]
    @picked_letters = params[:letters]

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    api_data = JSON.parse(response.read)

    def available_word
      @answer.chars.sort.all? { |letter| @answer.include?(@letters) }
    end

    if available_word = true
      if api_data['found']
        @case = "Congratulations! #{@answer} is a valid English word!"
      else
        @case = "Sorry but #{@answer.uppercase} does not seems to be a valid English word"
      end
    else
      @case = "Sorry but #{@answer.uppercase} can't be built out of #{@picked_letters}"
    end

  end

  def new
    @letters = 10.times.map { ALPHABET.sample }
  end

end
