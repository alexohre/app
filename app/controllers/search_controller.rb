class SearchController < ApplicationController
  def index

    @query = Article.ransack(params[:q])
  @articles = @query.result(distinct: true)
  # @articles = Article.all

  end
end
