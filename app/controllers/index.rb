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
  User.create(username: params[:username], password: params[:password])
  session[:messages] = ['New account created. Please sign in!']
  redirect '/'
end

get '/users/:id' do
  @all_decks = Deck.all
  erb :user_page
end

post '/rounds' do
  @current_round = prep_the_game(params[:deck_id])
  @round_id = @current_round.id
  redirect '/rounds/question_screen/' + @round_id.to_s
end

get '/rounds/question_screen/:round_id' do 
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
    erb :correct
  else
    @round.num_incorrect += 1
    @round.save
    erb :incorrect
  end
end