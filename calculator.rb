# ask user for two numbers
# ask user for operation
# perform operation
# output result

def prompt(message)
	Kernel.puts "=> #{message}"
end

def valid_number?(num)
	num.to_i != 0
end

def operation_to_message(op)
	case op 
	when '1'
		'Adding'
	when '2'
		'Subtracting'
	when '3'
		'Multiplying'
	when '4'
		'Dividing'
	end
end

prompt "Welcome to Calculator."
prompt "What is your name?" 
name = ''
loop do
	name = Kernel.gets.chomp

	if name.empty?
		prompt "Please use a valid name"
	else
		break
	end
end


num1, num2 = ''

prompt "Hi #{name}"

loop do  # main loop

	loop do 
		prompt "What is the first number?"
		num1 = Kernel.gets.chomp

		if valid_number?(num1)
			break
		else
			prompt "This doesn't look like a valid number"
		end
	end

	loop do 
		prompt "And the second number?"
		num2 = Kernel.gets.chomp

		if valid_number?(num2)
			break
		else
			prompt "This doesn't look like a valid number"
		end
	end

	prompt "Which operation would you like to use?"
	prompt "1. add"
	prompt "2. subtract"
	prompt "3. multiply"
	prompt "4. divide"

	operator = ''
	loop do
		operator = Kernel.gets.chomp

		if %w(1 2 3 4).include?(operator)
			break
		else
			prompt "Must choose a number between 1 and 4"
		end
	end

	prompt "#{operation_to_message(operator)} the two numbers..."

	result = case operator
						when '1'
							num1.to_i + num2.to_i
						when '2'
							num1.to_i - num2.to_i
						when '3'
							num1.to_i * num2.to_i
						when '4'
							num1.to_f / num2.to_f
	end

	prompt "The result equates to #{result}"

	prompt "Do you want to perform another calculation?(Y for yes)"
	answer = Kernel.gets.chomp
	break unless answer.downcase.start_with?('y')
end

prompt "Thanks for using the calculator"








