# Twenty-One Game
# Brian Weller

welcome = <<-MSG
  -------------------------------------------------
  Welcome to Twenty-One!
  You are playing against the Dealer...
  First to FIVE Wins!
  ----------------------------------------------------
MSG

FACES = ['2 of', '3 of', '4 of', '5 of', '6 of', '7 of', '8 of', '9 of', '10 of', 'Jack of', 'Queen of', 'King of', 'Ace of'].freeze
VALUES = %w(Hearts Spades Clubs Diamonds).freeze
HIGH_HAND = 21
HITS_BELOW = 17
def say(msg)
  puts "=> #{msg}"
end

def initialize_cards
  FACES.product(VALUES).shuffle
end

def find_value(cards)
  sum = 0
  rank = cards.collect { |card| card[0] }
  rank.each do |value|
    if value == 'Ace of'
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end
  rank.count('Ace of').times do
    sum -= 10 if sum > HIGH_HAND
  end
  sum
end

def busted?(hand)
  find_value(hand) > HIGH_HAND
end

def detect_result(dealer_hand, player_hand)
  player_total = find_value(player_hand)
  dealer_total = find_value(dealer_hand)
  if player_total > HIGH_HAND
    :player_busted
  elsif dealer_total > HIGH_HAND
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :push
  end
end

def display_result(dealer_hand, player_hand)
  result = detect_result(dealer_hand, player_hand)
  say '--------RESULT---------'
  case result
  when :player_busted
    say 'You busted!'
  when :dealer_busted
    say 'Dealer busted, you win!'
  when :player
    say 'You win!'
  when :dealer
    say 'Dealer wins!'
  when :push
    say 'Push!'
  end
end

def winner_scores_one(scores, winner)
  scores[winner] += 1
end

def play_again?
  say 'Do you want to play again? [y] or [n]'
  again = gets.chomp.downcase
  again.downcase.start_with?('y')
end

def who_won(dealer_total, player_total)
  say "Dealer stays with #{dealer_total}" if dealer_total <= HIGH_HAND
  say "You stayed with #{player_total}" if player_total <= HIGH_HAND
end

say(welcome)
sleep 1.5

scores = { 'dealer' => 0, 'player' => 0 }

# main game loop
loop do
  loop do
    loop do
      say 'Dealing cards...'
      sleep 1
      deck = initialize_cards
      player_hand = deck.pop(2)
      dealer_hand = deck.pop(2)
      say "Dealer has a #{dealer_hand[0]} showing."
      say "You have: #{player_hand[0]} and #{player_hand[1]}"
      say "For a total of #{find_value(player_hand)}"
      sleep 1

      loop do
        hit_or_stay = nil
        loop do
          say 'Do you [h]it or [s]tay?'
          hit_or_stay = gets.chomp.downcase
          break if ['h', 's'].include?(hit_or_stay)
          say 'You must enter [h] or [s]'
          sleep 1
        end
        break if hit_or_stay.downcase.start_with?('s')
        player_hand << deck.pop
        say "You drew a #{player_hand.last}."
        say "Your cards amount to: #{find_value(player_hand)}"
        sleep 1
        break if busted?(player_hand)
      end

      if busted?(player_hand)
        who_won(find_value(dealer_hand), find_value(player_hand))
        display_result(dealer_hand, player_hand)
        winner_scores_one(scores, 'dealer')
        break
      else
        say 'You chose to stay!'
        sleep 1
      end

      say "--------Dealer's Turn--------"
      sleep 1
      say "Dealer has: #{dealer_hand[1]} and #{dealer_hand[0]}"
      loop do
        dealer_total = find_value(dealer_hand)
        break if dealer_total > HITS_BELOW
        say "Dealer has #{find_value(dealer_hand)}"
        say '-------Dealer must hit-------'
        sleep 1
        dealer_hand << deck.pop
        say "Dealer drew a #{dealer_hand.last}"
        sleep 1
      end

      dealer_total = find_value(dealer_hand)
      player_total = find_value(player_hand)

      if busted?(dealer_hand)
        say "Dealer has #{dealer_total}"
        sleep 1
        who_won(dealer_total, player_total)
        display_result(dealer_hand, player_hand)
        winner_scores_one(scores, 'player')
        break
      end
      who_won(dealer_total, player_total)
      display_result(dealer_hand, player_hand)
      winner_of_the_hand = detect_result(dealer_hand, player_hand)
      winner_scores_one(scores, 'player') if winner_of_the_hand == :player
      winner_scores_one(scores, 'dealer') if winner_of_the_hand == :dealer

      break if scores['dealer'] == 5 || scores['player'] == 5
      say "Your score: #{scores['player']}. Dealer score: #{scores['dealer']}."
      sleep 1
    end
    say "Your score: #{scores['player']}. Dealer score: #{scores['dealer']}."
    sleep 1
    break if scores['dealer'] == 5 || scores['player'] == 5
  end
  break unless play_again?
end
say 'Thanks for playing!'
