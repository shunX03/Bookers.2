class BooksController < ApplicationController
 before_action :correct_user, only: [:edit]

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new

  end

  def create
    @book = Book.new(books_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "Your book has successfully posted"
      redirect_to book_path(@book.id)
    else
      render :index

    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
    flash[:notice] = "Your book has successfully been updating"
     redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def books_params
    params.require(:book).permit(:title, :body)
  end

 def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to books_path unless @user == current_user
 end
end

