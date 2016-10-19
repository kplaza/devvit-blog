require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require './models'

set :database, {adapter: 'sqlite3', database: 'devvit.sqlite3'}

enable :sessions
set :sessions => true

# $user = User.find(session[:user_id])

get '/' do
  @users = User.all
  erb :home
end



get '/signup' do

	erb :signup

end

post '/signup' do
	@user = User.create(username: params[:username], password: params[:password], email: params[:email])
	session[:user_id] = @user.id
	puts @user

	redirect '/post'

end

get '/signin' do


	erb :signin
end

post '/signin' do 
	@user = User.find_by(username: params[:username], password: params[:password])
	session[:user_id] = @user.id

	redirect '/post'
end

get "/signout" do 
  session[:user_id] = nil
  redirect '/'
end

get '/user/:id' do 
  @user = User.find(params[:id])
  erb :account
end

get '/post' do 
  @posts = Post.all
  @user = User.find(session[:user_id])
  erb :post
end

post '/post' do 
  
erb :post
end

get '/account' do 
@user = User.find(session[:user_id])
erb :account
	end

post '/update' do
	@updated_user = User.update(username: params[:username], password: params[:password], email: params[:email])
	@user = User.find_by(username: params[:username])
	session[:user_id] = @user.id

redirect '/account'
end


