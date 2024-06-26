class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else
            respond_to do |format|
                format.html { render :new, status: :unprocessable_entity }
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@article, partial: 'articles/form', locals: { article: @article }) }
            end
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            respond_to do |format|
                format.html { render :new, status: :unprocessable_entity }
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@article, partial: 'articles/form', locals: { article: @article }) }
            end
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

end