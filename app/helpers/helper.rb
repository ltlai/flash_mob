def prep_the_game(deck_id)
  @user_id = 2
  @new_round = Round.create(deck_id: deck_id, user_id: @user_id)
  return @new_round
end

def reset_cards(cards)
  cards.each do |card|
    card.shown = false
  end
end