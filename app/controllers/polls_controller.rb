class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @poll = Poll.find_by_code(params[:code])  
    @comment = Comment.new  
  end

  # POST /polls
  # POST /polls.json
  def create
    
    
    # create random hash as page URL
    length = 7
    params[:poll][:code] = rand(36**length).to_s(36)
    
      if params[:poll][:key_user].present?
        params[:poll][:key_user_salt] = BCrypt::Engine.generate_salt
        params[:poll][:key_user_hash] = BCrypt::Engine.hash_secret(params[:poll][:key_user], params[:poll][:key_user_salt])
      end
      
      if params[:poll][:key_admin].present?
        params[:poll][:key_admin_salt] = BCrypt::Engine.generate_salt
        params[:poll][:key_admin_hash] = BCrypt::Engine.hash_secret(params[:poll][:key_admin], params[:poll][:key_admin_salt])
      end
    
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        # set cookie to show that this is the visitor's poll
        cookies["last_poll"] = params[:poll][:code]
        
        # record all created polls to not forget them
        cookies["arnonym-poll-" + @poll.code] = params[:poll][:code]
        
        # deliver email if email was provided
        if @poll.email != ""
          @admin_notification = UserNotification.notify_admin(@poll.email, @poll.code).deliver
        end
        
        # auto login to last created poll - if pin was entered
        if params[:poll][:key_user].present?
          poll_auth = Poll.authenticate(params[:poll][:code], params[:poll][:key_user])
          if poll_auth
            session[:code] = params[:poll][:code]
          end
        end
        if params[:poll][:key_admin].present?
          poll_auth = Poll.authenticate_admin(params[:poll][:code], params[:poll][:key_admin])
          if poll_auth
            session[:code_admin] = params[:poll][:code]
          end
        end
        
        format.html { redirect_to root_url, notice: 'Poll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poll }
      else
        @categories = Category.all
        format.html { render '/home/index' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:poll_title, :description, :category_id, :code, :key_admin_hash, :key_admin_salt, :key_user_hash, :key_user_salt, :pageviews, :email)
    end
end
