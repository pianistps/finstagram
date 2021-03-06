class PostController < ApplicationController

  get '/posts' do
    if is_logged_in?(session)
      @posts = Post.all
      erb :'/posts/posts'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end

  get '/posts/new' do
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
    if is_logged_in?(session)
      @post = Post.find_by_id(params[:id])
      erb :'/posts/id'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end

  post '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    if is_logged_in?(session) && @post.user_id == current_user.id
      erb :'/posts/edit'
    elsif is_logged_in?(session) && @post.user_id != current_user.id
    flash[:error] = "This is not your post to edit"
    redirect '/posts'
    else
      flash[error] = "Please log in"
      redirect '/login'
    end
  end

  patch '/posts/:id' do
    post = Post.find_by_id(params[:id])
    if params[:caption] != ""
      post.update(caption: params[:caption])
      flash[:success] = "Post successfully updated!"
      redirect "/posts/#{post.id}"
    else
      flash[:error] = "Your post did not update correctly"
      redirect "/posts/#{post.id}/edit"
    end
  end

  delete '/posts/:id/delete' do
    post = Post.find_by_id(params[:id])
    if is_logged_in?(session) && post.user_id == current_user.id
      post.delete
      flash[:success] = "Post removed"
      redirect '/posts'
    elsif is_logged_in?(session) && post.user_id != current_user.id
      flash[:error] = "This is not your post to delete"
      redirect '/posts'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end

end
