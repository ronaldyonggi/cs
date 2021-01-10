## Solution template for Guess The Word practice problem (section 7)

# Change 1: Ignore punctuation.
# The first player may enter a phrase or sentence instead of a single word. The 
# current implementation doesn't treat spaces or punctuation marks in any special
# way. Change the game so that punctuation marks are not hidden from the second
# player. You should also reject non-letter characters as guesses.

# Change 2: Case Insensitivity
# The game currently treats lowercase and uppercase letters as being
# different. Change that so that entering either a lowercase or an uppercase
# letter as a guess would uncover all the corresponding letter in the secret word
# or phrase, regardless of their case.
# NOTE: You shouldn't just convert both the secret word and the guesses to lower
# or upper case -- that's not neat.

# Change 3: Forgive Repeated Guesses
# Player may try to guess the same letter absent from the secret phrase
# multiple times. The current implementation will consider all such guesses to be
# incorrect, and reduce the number of remaining attempts accordingly. Change the
# game so that repeated guesses are rejected as invalid instead.

require_relative './section-7-provided'

class ExtendedGuessTheWordGame < GuessTheWordGame
  ## YOUR CODE HERE
end

class ExtendedSecretWord < SecretWord
  ## YOUR CODE HERE
  # Override attr_accessor
  attr_accessor :word, :pattern, :guessed
  
  # Override initialize method to ignore punctuation
  def initialize word
    self.word = word
    # First convert the word input (string) into an array.
    array_word = word.split('')
    # Inititate the pattern to be an empty string
    pattern = ''
    # For each character in the array, if the character
    # is a letter, represent with '-', otherwise 
    # display the character.
    array_word.each{|x| if letter?(x) \
                        then pattern += '-' \
                        else pattern += x end}
    # Finally, assign pattern to self.pattern.
    self.pattern = pattern
    # guessed is an array containing the characters that have be
    # guessed by the player.
    self.guessed = []
  end

  # Override valid_guess? method
  def valid_guess? guess
    # convert guessed word to lowercase
    lowercased = guess.downcase
    # Guess is invalid if either: the length is not one, or the guess is not a letter,
    # or the letter was already guessed.
    if lowercased.length != 1 || !(letter?(lowercased)) | guessed.include?(lowercased)
      false
    else
      guessed.push(lowercased) # if valid input, add the lowercased guess to guessed array
      true
    end
  end

  # Override guess_letter! method to take into account uppercase letters as well.
  def guess_letter! letter
    upped = letter.upcase
    downed = letter.downcase
    found = self.word.index(upped) || self.word.index(downed)
    if found
        start = 0
        while ix = self.word.index(upped, start)
          self.pattern[ix] = self.word[ix]
          start = ix + 1
        end
        start = 0
        while ix = self.word.index(downed, start)
          self.pattern[ix] = self.word[ix]
          start = ix + 1
        end
      end
      found
  end

  # Helper method that checks whether a character is a letter
  def letter? char
    char =~ /[A-Za-z]/
  end
end


## Change to `false` to run the original game
if true
  ExtendedGuessTheWordGame.new(ExtendedSecretWord).play
else
  GuessTheWordGame.new(SecretWord).play
end

# To run, simply 'ruby solution.rb' in terminal