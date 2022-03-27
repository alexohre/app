class DashboardController < ApplicationController
  layout 'admin'

  def index
  end

  def articles
    @articles = Article.all
  end
  
end
