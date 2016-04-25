def say(message)
	Kernel.puts "=> #{message}"
end

loop do #main loop
	say "Welcome to the Mortgage Calculator"
	
	say "What is the loan amount?"

	amount = ''
	loop do
		amount = Kernel.gets.chomp

		if amount.empty? 
			say "Must enter a number"
		elsif amount.to_f < 0
			say "Must enter a positive number"
		else
			break
		end
	end

	say "What is your interest rate?"
	say "For example, 5 for 5%"

	interest_rate = ''
	loop do
		interest_rate = Kernel.gets.chomp

		if interest_rate.empty?
			say "Can't be empty"
		elsif interest_rate.to_f < 0
			say "Must enter positive number"
		else
			break
		end
	end

	say "What is the loan duration in years?"

	loanyears = ''
	loop do 
		loanyears = Kernel.gets.chomp

		if loanyears.empty?
			say "Can't be empty"
		elsif loanyears.to_f < 0
			say "Must be positive"
		else
			break
		end
	end

	annual_int_rate = interest_rate.to_f / 100
	monthly_int_rate = annual_int_rate / 12
	months = loanyears.to_i * 12

	mir = monthly_int_rate

	monthly_payment = amount.to_f * (mir / (1 - (1 + mir)**-months.to_i ))

	say "So, your monthly payment is: $#{format('%.02f', monthly_payment)}"

	say "Another Calculation?"
	answer = Kernel.gets.chomp

	break unless answer.downcase.start_with?('y')

end

say "Thanks for using the Mortgage Calculator"









