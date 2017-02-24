class UsersController < ApplicationController
  def index
  end

  def create
    user= User.new(name: params[:name], alias: params[:alias], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if !user.valid?
      flash[:error] = "You have errors"
      redirect_to '/'
    else
      flash[:success] = "You did it!"
      User.create(name: params[:name], alias: params[:alias], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      redirect_to '/'
    end
  end

  def login
    user= User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]
      redirect_to '/bright_ideas'
    else
      render text: "Something was wrong with Login credentials"
    end
  end

  def main
    if session[:user_id]
      @user_me=User.find(session[:user_id])
      @ideas=Idea.all
    else
      redirect_to '/'
    end
  end

  def idea_create
    user = User.find(params[:id])
    thing = Idea.new(content:params[:content], user:user)
    if thing.save
      flash[:create] = "You just added a new secret"
    else
      flash[:create] = "FAILED to add new secret"
    end
    redirect_to('/bright_ideas')
  end

  def edit
  end

  def logout
    session.clear
    redirect_to '/'
  end

  def like
    @user_id = session[:user_id]
    Like.create(idea_id: params[:id], user_id: @user_id)
    flash[:success]= ["Like Added!"]
    redirect_to "/bright_ideas"
  end

  def unlike
    @user_id=session[:user_id]
    Like.where(idea_id: params[:id], user_id: @user_id)[0].destroy
    flash[:success]= ["Like changed to UNLIKE!"]
    redirect_to "/bright_ideas"
  end

  def delete
    Idea.find(params[:id]).destroy
    redirect_to "/bright_ideas"
  end

  def idea
    @idea=Idea.find(params[:id])
    @users_liked=@idea.users_liked
  end

  def show
    @user=User.find(params[:id])
    @ideas=@user.ideas
    @ideas_liked_by_user=@user.ideas_liked
  end

end
