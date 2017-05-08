class UsersController < ApplicationController
  


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end


  def show
    @user=User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 1)
  end


  def new
    @user = User.new
  end

  
  def edit
    @user=User.find(params[:id])
  end


  def create
    @user = User.new(user_params)

      if @user.save
        flash[:notice] = 'Welcome to the Alpha Blog' 
        redirect_to articles_path
      else
        render 'new'
      end
    
  end


  def update
    @user=User.find(params[:id])
      if @user.update(user_params)
        flash[:notice]= 'User was successfully updated.'
        redirect_to articles_path
      else
        render 'edit'
      end
  end

  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
