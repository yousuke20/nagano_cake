class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

# 新規登録ジャンルデータの保存
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = '編集内容を保存しました！'
      redirect_to admin_genres_path
    else
      flash[:danger] = '内容に不備があります！'
      render :index
    end  
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = '編集内容を保存しました！'
      redirect_to admin_genres_path
    else
      flash[:danger] = '内容に不備があります！'
      render :edit
    end  
  end

  # ジャンルデータのストロングパラメータ
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
