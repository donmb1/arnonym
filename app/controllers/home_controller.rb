class HomeController < ApplicationController
  
  def index
    @poll = Poll.new
    @categories = Category.all
  end

end