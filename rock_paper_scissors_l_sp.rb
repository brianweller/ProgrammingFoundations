# Brian Weller
# rock_paper_scissors_l_sp.rb
# Variation on the typical rps game

def say (message)
	Kernel.puts "=> #{message}"
end

VALID_CHOICES = %w(r p sc l sp).freeze

CHOICES = {'r' => 'rock', 
					'p' => 'paper', 
					'sc' => 'scissors',
					'l' => 'lizard',
					'sp' => 'spock'}

WINNING_PAIRS = {'r' => %w(sc l),
								'p' => %w(r sp),
								'sc' => %w(p sc),
								'l' => %w(sp p),
								'sp' => %w(sc r)}



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

say (welcome)

user_score = 0
comp_score = 0

choice = ''

while user_score && comp_score < 5

	loop do 
		say (prompt_to_user)
		choice = Kernel.gets.chomp

		if VALID_CHOICES.include?(choice)
			break
		else
			say "That's not valid"
		end	
	end

	comp_choice = VALID_CHOICES.sample
	say "You chose "

end














