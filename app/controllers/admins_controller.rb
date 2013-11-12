class AdminsController < ApplicationController
  
  def index
    
    @poll = Poll.find_by_code(params[:code])
    
  end
  
end
