class AdminsController < ApplicationController
  
  def index
    
    @poll = Poll.find_by_code(params[:code])
    @comments = Comment.where(:poll_id => @poll.id).order('created_at DESC')
  
  end
  
end
