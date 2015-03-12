get '/intro' do
  erb :introduction, :layout => false
end

get '/' do
  if current_user != nil
    user = User.find(current_user)
    @lists = user.lists
    erb :index
  else
    redirect '/login'
  end
end

get '/login' do
  erb :login
end

post '/login' do
  if user_auth
    redirect '/'
  else
    @login_error = "Please try again."
    @wrong_username = params[:username]
    @wrong_password = params[:password]
    erb :login
  end
end

post '/register' do
  p params
  @user = User.new(username: params[:username], password: params[:password])
  if @user.save
    set_user
    redirect '/'
  else
    @register_errors = @user.errors.full_messages
    @username = params[:username]
    @password = params[:password]
    status 404
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end