
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #leave blank
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    @new_post = Post.create(params)
    redirect to '/posts'
  end

  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end

  get '/posts/:id/edit' do #id is being interpolated here-colon makes dynamic route
    @post = Post.find_by(id: params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

  delete '/posts/:id/delete' do
    #to initiate this action-make delete button in form of a form
    #form will send post request to delete controller action, where will identify post to delete and delete it
    #action will render delete.erb view which confirms that post has been deleted
    @post = Post.find_by(id: params[:id])
    @post.destroy
    erb :delete

  end

end
