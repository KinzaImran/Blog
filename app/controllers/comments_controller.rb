class CommentsController < ApplicationController
#before_filter :authenticate_user!

def new
  @article = Article.find(params[:article_id])
  @comment = Comment.new
  end

def create
 @article = Article.find_by_id(params[:article_id])
 @comments=@article.comments
 #@commment = Comment.find params[:id]
 @comment = @article.comments.create(params.require(:comment).permit(:body))
 #@comment = current_user.comments.new(comment_params)
 #redirect_to article_path(@article)

 #respond_to do |format|
  #format.html redirect_to @article
  #format.js #render comments/create.js.erb
 #end
#end
respond_to do |format|
  if @comment.save
    format.html { redirect_to @article, notice: 'Comment was successfully created.' }
    format.json { render json: @comment, status: :created, location: @comment }
  else
    format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
  end
 end
end
 
def destroy
 @article = Article.find(params[:article_id])
 @comment = @article.comments.find(params[:id])
 @comment.destroy
 redirect_to articles_path
end

def show
  @commment = Comment.find params[:id]
 end
end
 
  

