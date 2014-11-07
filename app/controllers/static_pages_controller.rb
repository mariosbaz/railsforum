class StaticPagesController < ApplicationController
  def home
  	@recentposts = Post.all(order: 'created_at DESC', limit: 10)
  end
end
