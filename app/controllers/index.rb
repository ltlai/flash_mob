get '/' do
  # Form to create account
  # Form to log in
  erb :index
end

post '/sign_in' do
  current_user = User.authenticate(params[:username], params[:password])
  if current_user
    session[:user_id] = current_user.id
    redirect '/users/:id'
  else
    redirect '/invalid_login'
  end
end

post '/sign_up' do
  User.create(username: params[:username], password: params[:password])
  # create new user
  redirect '/'
end

get '/users/:id' do
  # User Page with user stats
  # Displays all decks to choose from
  erb :user_page
end

post '/rounds/:deck_id' do
  @current_round = prep_the_game
  @current_round.id
  redirect '/question_screen/:round_id'
end

get '/rounds/:round_id/question_screen' do 
  if session[:deck].any?
    erb :game_page
  else
    redirect '/users/#{sessions[:id]}'
  end
end

post '/rounds/:round_id/answer' do
  # store correct/incorrect in session or in round object
end

get '/result_page'  do
  # correct or incorrect
  erb :result_page
end



=begin

1 - Homepage, login, create account
  '/'
  session[:id] = user_id

2 - User page
  '/users/:id'
  displaying decks
  -linked to rounds
  previous rounds (stretch)

3 - Running a Round
  '/rounds/:deck_id'
  Round.create with user_id(session) and deck_id
  -logic
    -shuffle/find deck

in the round model -
  we need method to iterate our deck
 
=end