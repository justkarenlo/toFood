post '/list/new' do
  user = User.find(current_user)
  user.lists.create(name: params[:list_name], user_id: current_user)

  redirect '/'
end

get '/lists/:list_id' do
  @list = List.find(params[:list_id])
  erb :'videos/view'
end

delete '/delete/list/:list_id' do
  list = List.find(params[:list_id])
  list.destroy
end