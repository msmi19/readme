class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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

  private

  def book_params
    params.require(:book).permit(:name, :description, :author)
  end
end
