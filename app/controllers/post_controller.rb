class PostController < ApplicationController

  get '/posts' do
    if is_logged_in?(session)
      @posts = Post.all
      erb :'/posts/posts'
    else
      flash[:error] = "Please log in."
      redirect '/login'
    end
  end

  get '/posts/new' do
    # "hello new post"
    if is_logged_in?(session)
      erb :'/posts/new'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end

  post '/posts' do
    if params[:post_photo] && params[:caption] != ""
      Post.create(post_photo: params[:post_photo], caption: params[:caption], user_id: session[:user_id])
      flash[:success] = "Post successfully made!"
      redirect '/posts'
    else
      flash[:error] = "Please make sure both fields are present."
      redirect '/posts/new'
    end
  end

  get '/posts/:id' do
    # "hello post id"
    if is_logged_in?(session)
      @post = Post.find_by_id(params[:id])
      erb :'/posts/id'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end

  post '/posts/:id/edit' do
    "edit post!"
  end

end
