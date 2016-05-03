# Tic Tac Toe!
# By Brian Weller

welcome = <<-MSG
  -------------------------------------------------
  Welcome to the Tic-Tac-Toe Game!
  You are playing against the Computer...
  Your Marker is X. Computer's Marker is O.
  First to FIVE Wins!
  ----------------------------------------------------
MSG

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]].freeze

def say(msg)
  puts "=> #{msg}"
end

def joinor(array, middle = ', ', word = 'or')
  array[-1] = "#{word} #{array.last}" if array.size > 1
  array.join(middle)
end

def display_board(brd)
  system 'clear' or system 'cls'
  say "Your marker: #{PLAYER_MARKER}. Computer's marker: #{COMPUTER_MARKER}."
  say 'You are playing first to 5 wins...'
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----|-----|-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----|-----|-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def alternate_player(current_player)
  if current_player == 'Computer'
    'Player'
  elsif current_player == 'Player'
    'Computer'
  end
end

def difficulty_of_game
  answer = ''
  loop do
    say 'Would you like to play easy or hard?'
    sleep 1.5
    say 'Please enter [e] for easy, and [h] for hard.'
    answer = gets.chomp
    break if answer.downcase.start_with?('e', 'h')
    say 'That is not valid...'
  end
  answer
end

def first_or_second
  turn_ans = ''
  loop do
    say 'Would you like to go first or second?'
    sleep 1.5
    say 'Enter [1] to go first, enter [2] to go second...'
    turn_ans = gets.chomp
    break if turn_ans.downcase.start_with?('1', '2')
    say 'That is not valid...'
  end

  if turn_ans.downcase.start_with?('1')
    'Player'
  elsif turn_ans.downcase.start_with?('2')
    'Computer'
  end
end

def place_piece!(board, current_player, difficulty_answer)
  if current_player == 'Computer'
    comp_places_piece!(board, difficulty_answer)
  elsif current_player == 'Player'
    player_places_piece!(board)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    say "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    say "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def comp_smart_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |piece, empty_square| line.include?(piece) && empty_square == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def comp_places_piece!(brd, difficulty_answer)
  square = nil
  WINNING_LINES.each do |line|
    if difficulty_answer.downcase.start_with?('h')
      square = comp_smart_square(line, brd, COMPUTER_MARKER)
      break if square
    end
  end

  if !square
    WINNING_LINES.each do |line|
      square = comp_smart_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square && difficulty_answer.downcase.start_with?('h')
    square = 5 if brd[5] == INITIAL_MARKER
  end

  if !square
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def winning_messages(board)
  if someone_won?(board)
    display_board(board)
    say "#{detect_winner(board)} won!"
  elsif board_full?(board)
    display_board(board)
    say 'TIE GAME'
  end
end

def show_game_score(board, score)
  if board_full?(board) || someone_won?(board)
    say "Player score: #{score[:player_wins]}."
    say "Computer score: #{score[:computer_wins]}."
    say "Number of ties: #{score[:ties]}."
  end
end

def win_messages(score)
  if score[:player_wins] == 5
    say 'You are the first to 5 wins!'
  elsif score[:computer_wins] == 5
    say 'Computer is first to 5 wins...'
    say 'Maybe next time...'
  end
end

def score_tracking(score, board)
  if detect_winner(board) == 'Player'
    score[:player_wins] += 1
  elsif detect_winner(board) == 'Computer'
    score[:computer_wins] += 1
  elsif board_full?(board)
    score[:ties] += 1
  end
end

def stop_playing?(board, score)
  if detect_winner(board) || board_full?(board)
    game_number = score[:player_wins] + score[:computer_wins] + score[:ties] + 1
    say "game number #{game_number} is next..."
    say 'Enter any key to continue or [f] to forfeit.'
    answer = gets.chomp
    answer.downcase.start_with?('f')
  end
end

say(welcome)
sleep 1.5

score = { player_wins: 0, computer_wins: 0, ties: 0 }

difficulty_answer = difficulty_of_game
first_turn = first_or_second

current_player = first_turn
board = initialize_board

# game loop
loop do
  display_board(board)

  # gameplay
  place_piece!(board, current_player, difficulty_answer)
  sleep 0.5
  current_player = alternate_player(current_player)

  # messages after game
  winning_messages(board)
  score_tracking(score, board)
  show_game_score(board, score)

  # end game
  win_messages(score)
  break if score[:player_wins] == 5 || score[:computer_wins] == 5
  break if stop_playing?(board, score)

  # reset
  if board_full?(board) || someone_won?(board)
    current_player = first_turn
    board = initialize_board
  end
end

say 'Thanks for playing!'
