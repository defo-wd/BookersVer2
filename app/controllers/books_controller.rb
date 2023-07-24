class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:home, :about, :new, :create]

  def new
    @book = Book.new
  end

  def create
    @books =Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "Book create successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book updated successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

 def is_matching_login_user
  book = Book.find(params[:id])
  unless book.user_id == current_user.id
    redirect_to books_path
  end
 end



  def book_params
    params.require(:book).permit(:title, :body)
  end
end
