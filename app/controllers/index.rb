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
  if User.find_by_username(params[:username]) == nil
    User.create!(username: params[:username], password: params[:password])
    session[:messages] = ['New account created. Please sign in!']
  else
    session[:messages] = ['Sorry, that username has been taken']
  end
  redirect '/'
end

get '/users/:id' do
  @all_decks = Deck.all
  erb :user_page
end

post '/rounds' do
  @round = prep_the_game(params[:deck_id])
  redirect "/rounds/#{@round.id}/question_screen"
end

get '/rounds/:round_id/question_screen' do 
  @cards = Round.find(params[:round_id]).deck.cards
  @card = @cards.select { |card| card.shown == false }.sample
  if @card
    @card.shown = true
    @card.save
    @round_id = params[:round_id]
    erb :game_page
  else
    reset_cards(@cards)
    redirect '/users/' + session[:user_id].to_s
  end
end

post '/rounds/answer/:round_id/:card_id' do |round, card|
    @round = Round.find_by_id(round)
  if params[:guess].downcase == Card.find_by_id(card).answer.downcase
    @round.num_correct += 1
    @round.save
    redirect "/rounds/answer/#{@round.id}/correct"
  else
    @round.num_incorrect += 1
    @round.save
    redirect "/rounds/answer/#{@round.id}/incorrect"
  end
end

get '/rounds/answer/:round_id/correct' do
  @round = Round.find_by_id(params[:round_id])
  erb :correct
end

get '/rounds/answer/:round_id/incorrect' do
  @round = Round.find_by_id(params[:round_id])
  erb :incorrect
end

get '/users/stats/:id' do
  @stats = retrieve_stats(params[:id].to_i)
  erb :user_stats
end
