require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @letter_in_grid = letter_in_grid(@word, @letters)
    @english_word = english_word(@word)
  end

  private

  def letter_in_grid(word, letters)
    word.chars.sort.all? { |letter| letters.include?(letter) }
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = URI.open(url)
    word = JSON.parse(word_dictionary.read)
    return word['found']
  end

end

# 1 show array
# @letters = Array.new(10) { ('A'..'Z').to_a.sample }
# @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
# 2 pick and submit letters frm array
# 3 check if array letters are submitted
# @work included?
# 4 compute score of array letters in a word
