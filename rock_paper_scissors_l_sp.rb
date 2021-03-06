# Brian Weller
# rock_paper_scissors_l_sp.rb
# Variation on the typical rps game

# indent method
def say(message)
  Kernel.puts "=>  #{message}"
end

# method that shows results per round
def show_results(user, comp)
  if winner(user, comp)
    say 'You won that round!'
  elsif winner(comp, user)
    say 'The computer won that round..'
  else
    say 'That round was a TIE'
  end
end

def winner(one, two)
  WINNING_PAIRS[one].include?(two)
end

def move(choice)
  CHOICES[choice]
end

def clear_screen
  system('cls')
end

VALID_CHOICES = %w(r p sc l sp).freeze

CHOICES = { 'r' => 'rock',
            'p' => 'paper',
            'sc' => 'scissors',
            'l' => 'lizard',
            'sp' => 'spock' }.freeze

WINNING_PAIRS = { 'r' => %w(sc l),
                  'p' => %w(r sp),
                  'sc' => %w(p sc),
                  'l' => %w(sp p),
                  'sp' => %w(sc r) }.freeze

welcome = <<-MSG
	----------------------------------------------------
	Welcome to the Rock-Paper-Scissors-Lizard-Spock Game
	* A Variation on the typical RPS Game *
	You are playing against the Computer...
	First to FIVE Wins!
	You have five choices.
	----------------------------------------------------
MSG

prompt_to_user = <<-MSG
	Please Choose One:
  		 'r' for rock
		 'p' for paper
		 'sc' for scissors
		 'l' for lizard
		 'sp' for spock
MSG

say(welcome)

user_score = 0
comp_score = 0

choice = ''

# main loop
while user_score < 5 && comp_score < 5

  # loop to verify a valid input
  loop do
    say(prompt_to_user)
    choice = Kernel.gets.chomp.downcase

    break if VALID_CHOICES.include?(choice)
    say "That's not valid"
  end

  # get comp random choice
  comp_choice = VALID_CHOICES.sample

  say "You chose #{move(choice)};
				While the computer chose #{move(comp_choice)}."

  show_results(choice, comp_choice)

  # add 1 when win
  if winner(choice, comp_choice)
    user_score += 1
  elsif winner(comp_choice, choice)
    comp_score += 1
  end

  # tell the user the score
  say "Your score: #{user_score}."
  say "The computer's score: #{comp_score}."

  say '-----SUDDEN DEATH-----' if user_score == 4 && comp_score == 4

  say 'One more round win and you WIN...' if user_score == 4

  say 'The computer only needs one more round win to WIN...' if comp_score == 4

  clear_screen

end

if user_score == 5
  say 'Congrats, you won the Game!'
  say "The score was #{user_score} to #{comp_score}."
else
  say 'The computer won the game...'
  say "The score was #{comp_score} to #{user_score}. Maybe next time!"
end

say 'Thank you for playing.'
