get '/' do
  @messages = session.delete(:messages) || []
  erb :index
end

post '/sign_in' do
  current_user = User.authenticate(params[:username], params[:password])
  if current_user
    session[:user_id] = current_user.id
    redirect "/users/#{current_user.id}"
  else
    session[:messages] = ['Invalid login']
    redirect '/'
  end
end

post '/sign_up' do
  if taken?(params[:username])
    session[:messages] = ['Sorry, that username has been taken']
  else
    User.create!(username: params[:username], password: params[:password])
    session[:messages] = ['New account created. Please sign in!']
  end
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:id' do
  @all_decks = Deck.all
  erb :user_page
end

post '/rounds' do
  @round = prep_the_game(params[:deck_id])
  cards = Round.find(@round.id).deck.cards
  reset_cards(cards)
  redirect "/rounds/#{@round.id}/question_screen"
end

get '/rounds/:round_id/question_screen' do 
  @round_id = params[:round_id]
  @cards = Round.find(@round_id).deck.cards
  @card = @cards.select { |card| card.shown == false }.sample
  if @card
    @card.show
    erb :game_page
  else
    reset_cards(@cards)
    redirect "/rounds/#{@round_id}/summary"
  end
end

get '/rounds/:round_id/summary' do
  @round = Round.find_by_id(params[:round_id])
  @correct_guesses = @round.num_correct
  @incorrect_guesses = @round.num_incorrect
  erb :round_summary_page
end

post '/rounds/:round_id/cards/:card_id/answer' do |round, card|
  @round = Round.find_by_id(round)
  if correct?(params[:guess], card)
    @round.record_correct
    redirect "/rounds/#{@round.id}/correct"
  else
    @round.record_incorrect
    redirect "/rounds/#{@round.id}/incorrect"
  end
end

get '/rounds/:round_id/correct' do
  @round = Round.find_by_id(params[:round_id])
  erb :correct
end

get '/rounds/:round_id/incorrect' do
  @round = Round.find_by_id(params[:round_id])
  erb :incorrect
end

get '/users/stats/:id' do
  @stats = retrieve_stats(params[:id])
  erb :user_stats
end


post '/create_deck' do
  p params
  @deck =Deck.create(params)
  @all_decks = Deck.all
  erb :user_page
end