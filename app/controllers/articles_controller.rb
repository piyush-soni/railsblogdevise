class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  skip_before_action :require_user, only: [:index, :show]

  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id])
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to @article
    else
      flash[:success] = "Article was not updated"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "article was deleted"
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
