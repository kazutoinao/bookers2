class UsersController < ApplicationController
before_action :authenticate_user!
before_action :correct_post,only: [:edit ]
  def show
    @user=User.find(params[:id])
    @book=@user.books
    @book_new=Book.new
  end

  def index
   @users=User.all
   @user=current_user
   @book_new=Book.new
  end

  def edit
   @user=User.find(params[:id])
  end

  def correct_post
        @user=User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
   @user=User.find(params[:id])
   @users=User.all
   if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user)
   else
     render :edit
   end
  end


  private
  def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
  end

   def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
   end

end