def prep_the_game(deck_id)
  @user_id = session[:user_id]
  @new_round = Round.create(deck_id: deck_id, user_id: @user_id)
  return @new_round
end

def reset_cards(cards)
  cards.each do |card|
    card.shown = false
    card.save
  end
end

def retrieve_stats(user_id)
  @rounds = Round.where(user_id: user_id)
end

