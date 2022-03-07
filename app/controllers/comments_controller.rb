class CommentsController < ApplicationController
  before_action :find_commentable, only: :create
  
    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user = current_user
      
      if @comment.save
        redirect_to article_path(@article), notice: "comment created successfully"
      else
        redirect_to root_path, alert: "error in comment"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_commentable
      if params[:comment_id]
        @commentable = Comment.find_by_id(params[:comment_id]) 
      elsif params[:article_id]
        @commentable = Article.find_by_id(params[:article_id])
      end
    end

end
  