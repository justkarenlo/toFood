# displays all of user's videos
get '/videos' do
  if current_user
    user = User.find(current_user)
    @lists = user.lists
    erb :'videos/all'
  else
    @login_error = "Log in first to access videos saved by you."
    erb :login
  end
end

# displays all videos from VIDEO SEARCH
post '/videos' do
  keyword = params[:keywords] + "recipe"
  keyword = keyword.split(" ").join("+")

  opts = Trollop::options do
    opt :q, 'Search term', :type => String, :default => keyword
    opt :maxResults, 'Max results', :type => :int, :default => 25
  end

  client = Google::APIClient.new(:key => ENV['SERVER_KEY'],
   :authorization => nil)
  youtube = client.discovered_api("youtube", "v3")

  # Call the search.list method to retrieve results matching the specified
  # query term.
  opts[:part] = 'id,snippet'
  search_response = client.execute!(
    :api_method => youtube.search.list,
    :parameters => opts
    )

  @videos = []
  @channels = []
  @playlists = []

# Add each result to the appropriate list, and then display the lists of
# matching videos, channels, and playlists.
  search_response.data.items.each do |search_result|
    case search_result.id.kind
    when 'youtube#video'
      @videos.push(search_result.id.videoId)
    when 'youtube#channel'
      @channels.push("#{search_result.snippet.title} (#{search_result.id.channelId})")
    when 'youtube#playlist'
      @playlists.push("#{search_result.snippet.title} (#{search_result.id.playlistId})")
    end
  end

  if current_user != nil
    user = User.find(current_user)
    @lists = user.lists
    erb :'videos/results'
  else
    @login_error = "You must be logged in to search for recipes."
    erb :login
  end

end

post '/videos/new' do
  if params[:list_options] != "nope"
    user = User.find(current_user)
    list = user.lists.find(params[:list_options].to_i)
    list.videos.create(unique_id: params[:video_id])
    redirect '/'
else
  @error = "Please select a valid list."
  user = User.find(current_user)
    @lists = user.lists
  erb :'index'
  end
end

delete '/video/:video_id' do
  video = Video.find(params[:video_id])
  video.destroy
  content_type :json
  {status: "successful"}.to_json
end