class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
    # :idじゃない↓
      redirect_to book_path(@book)
    else
      # index.htmlには@booksと@userと@bookの三つがあるからcreateにも三つ入れる
      # ここに@booksと@userを入れるのが好ましい
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new

  end

  def show
    # @user = User.find(params[:id])
    # 特定の本を投稿してくれた①
    @book = Book.find(params[:id])
    @user = @book.user
    # user②
    # @books = @book.user
    @boooks = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


  def correct_user
    # 書いた本
    @book = Book.find(params[:id])
    # 著者
    @user = @book.user
    # 著者しか開けないようにする
    redirect_to books_path unless @user == current_user
  end


end