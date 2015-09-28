class UsersController < ApplicationController
before_action :logged_in_user,only: [:edit,:update]
before_action :correct_user,only: [:edit,:update]
  def new
  @user = User.new
  end
  
  def show
@user = User.find(params[:id])
end

def index
@users = User.all
  end

def create
@user = User.new(user_params)
if @user.save
flash[:success] = "User successfully logged in!"
redirect_to @user
else
render 'new'
 end
end
 
 def edit
@user = User.find(params[:id])
end

def update
@user = User.find(params[:id])
if @user.update_attributes(user_params)
flash[:success] = "Profile updated"
redirect_to @user
else
render 'edit'
 end
end
private
def user_params
params.require(:user).permit(:name,:email,:password,
:password_confirmation)
 end
# Confirms a logged-in user.
def logged_in_user
unless logged_in?
flash[:danger] = "Please log in."
redirect_to root_url
else 
render 'new'
end
end
def correct_user
@user = User.find(params[:id])
# redirect_to(root_url) unless current_user?(@user)
redirect_to(root_url) unless @user == current_user
end
# Stores the URL trying to be accessed.
def store_location
session[:forwarding_url] = request.url if request.get?
end
def redirect_back_or(default)
redirect_to(session[:forwarding_url] || default)
session.delete(:forwarding_url)
end
def logged_in_user
unless logged_in?
store_location
flash[:danger] = "Please log in."
redirect_to root_url
end
end 
end

