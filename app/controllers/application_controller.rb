
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Create get: Load new form for user to input new blog post
  get '/posts/new' do
    erb :new
  end

  # Read get: Load index page to list all blog posts
  get '/posts' do
    @posts = Post.all

    erb :index
  end

  # Create post: Create new post to the database
  post '/posts' do
    @post = Post.create(params)

    redirect :posts
  end

  # Read get: Load show page to display an individual blog post
  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])

    erb :show
  end

 # Update get:  Load edit page to display an individual blog post and allow user to edit the post instance
  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])

    erb :edit
  end

  # Edit Patch post: Update the post instance
  patch '/posts/:id' do
    post = Post.find_by_id(params[:id])
    post.name = params[:name]
    post.content = params[:content]
    post.save

    redirect :"/posts/#{post.id}"
  end

  # Delete Post: Delete the post instance
  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @post.destroy

    erb :delete
  end
end
