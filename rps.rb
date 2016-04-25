VALID_CHOICES = ['rock', 'paper', 'scissors']

def say(message)
	Kernel.puts "=> #{message}"
end

loop do
	choice = ''
	loop do 
		say "Choose one: #{VALID_CHOICES.join(', ')}"
		choice = Kernel.gets.chomp

		if VALID_CHOICES.include?(choice)
			break
		else
			say "That's not valid"
		end	

	end

		computer_choice = VALID_CHOICES.sample

		say "You chose: #{choice}; Computer chose: #{computer_choice}"

		if (choice == 'rock' && computer_choice =='scissors') ||
						(choice == 'paper' && computer_choice == 'rock') ||
						(choice == 'scissors' && computer_choice == 'paper')
				say "You Won"

		elsif (choice == 'rock' && computer_choice == 'paper') ||
						(choice == 'paper' && computer_choice == 'scissors') ||
						(choice == 'scissors' && computer_choice == 'rock')
				say "You Lost"

		else
				say "There's a TIE"
		end

		say "Do you want to play again?"
		answer = Kernel.gets.chomp
		break unless answer.downcase.start_with?('y')
end

say "Thanks for playing."



