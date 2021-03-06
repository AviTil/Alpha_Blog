class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end


  def show
    
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 1)
  end


  def new
    @user = User.new
  end

  
  def edit
    
  end


  def create
    @user = User.new(user_params)

      if @user.save
        session[:user_id]=@user.id
        flash[:notice] = 'Welcome to the Alpha Blog' 
        redirect_to user_path(@user)
      else
        render 'new'
      end
    
  end


  def update
      if @user.update(user_params)
        flash[:notice]= 'User was successfully updated.'
        redirect_to articles_path
      else
        render 'edit'
      end
  end

  
  def destroy
    @user.destroy
    flash[:danger]="The user and all articles relating to the user have been deleted"
    redirect_to users_path

  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:notice]="You may only edit your own account"
        redirect_to users_path
      end
    end
    
end
