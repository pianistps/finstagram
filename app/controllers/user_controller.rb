class UserController < ApplicationController

  get '/users/:slug' do
    # "user's profile"
    @user = User.find_by_slug(params[:slug])
    erb :'/users/users'
  end

  get '/login' do
    # "log in!!"
    if !is_logged_in?(session)
      erb :'/users/login'
    else
      redirect '/posts'
    end
  end

  post '/login' do
    user = User.find(username: params[:username], password: params[:password])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/posts'
    else
      flash[:error] = "Your login information seems to be incorrect."
      redirect '/login'
    end
  end

  get '/signup' do
    # "Sign up"
    if !is_logged_in?(session)
      erb :'/users/new'
    else
      redirect '/posts'
    end
  end

  post '/signup' do
    if params.none? {|k, v| v == ""}
      user = User.create(username: params[:username], learn_handle: params[:learn_handle], user_photo: params[:user_photo], password: params[:password])
      session[:user_id] = user.id
      flash[:success] = "Created successfully!"
      redirect '/posts'
    else
      flash[:error] = "Unsuccessfully created."
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    flash[:success] = "See you next time!"
    redirect '/login'
  end

end
