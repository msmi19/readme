class BooksController < ApplicationController
  def index 
    @books = Book.paginate(page: params[:page])
  end

  def new
    @book = Book.new
  end
end
