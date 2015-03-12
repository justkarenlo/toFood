helpers do

  def set_user
    session[:user_id] = @user.id
  end

  def user_auth
    user = User.find_by(username: params[:username])
    if user != nil && user.password == params[:password]
      session[:user_id] = user.id
      return true
    else
      return false
    end
  end

  def current_user
    session[:user_id]
  end

end