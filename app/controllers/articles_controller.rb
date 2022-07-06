class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except:[:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
  end

  def index
    @articles = Article.all
    render json: @articles
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article 
    else
      render 'new'
    end
  end

  def update
     @article.update(article_params)
     render json: @article
  end

#  def update
#    begin
#     @article.update(article_params)
#     response = @article
#     raise "is fuckerd up" if true     
#    rescue => exception
#     response = {error: "there was an error"}
#    end  
#    render json: response
# end


  def destroy
    @article.destroy
    render json: "article destroyed"
  end

  private 
  
  def set_article
   @article = Article.find(params[:id])
  end
  
  
  def article_params 
    params.permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end


end
