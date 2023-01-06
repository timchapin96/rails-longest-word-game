require 'open-uri'
require 'JSON'
class GamesController < ApplicationController
  def new
    letters = []
    alphabet = ('A'..'Z').to_a
    10.times do
      letters << alphabet[rand(26)]
    end
    @real_letters = letters
  end

  def score
    @is_in_grid = true
    @guess = params[:guess]
    @dictionary = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}").read)
    @letters = params[:letters].split(' ')
    letters = @letters.map(&:clone)
    @guess.upcase.split('').each do |guess_letter|
      if letters.include?(guess_letter)
        letters.delete_at(letters.index(guess_letter).to_i)
      else
        @is_in_grid = false
        break
      end
    end
  end
end
