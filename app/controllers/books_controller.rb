class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index 
    @books = Book.paginate(page: params[:page])
  end

  def new
    @book = Book.new
  end

  def create
    current_user.books.create(book_params)
    redirect_to root_path
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end
end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @book.update_attributes(book_params)
    redirect_to root_path
  end

  def destroy 
    @book = Book.find(params[:id])
    if @book.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @book.destroy
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :description, :author)
  end
end
