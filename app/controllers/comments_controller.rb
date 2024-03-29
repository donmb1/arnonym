class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @poll = Poll.find_by_id(params[:comment][:poll_id])
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        
        cookies["comment-" + @poll.code] = @poll.code
        
        # deliver email to admin if email was provided
        if @poll.email != ""
          @admin_notification = UserNotification.notify_admin_of_comment(@poll.email, @poll.code).deliver
        end
        
        if !@poll.key_user_hash
          format.html { redirect_to "/"+ @poll.code, notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to "/"+ @poll.code + "?h=" + Digest::MD5.hexdigest(@poll.key_user_hash), notice: 'Comment was successfully created.' }
        end
        format.json { render action: 'show', status: :created, location: @comment }
      else
        # to keep users that came from email alive - send hash as param
        if @poll.key_user_hash
          params['h'] = Digest::MD5.hexdigest(@poll.key_user_hash)
        end
        
        format.html { render '/polls/index' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:poll_id, :comment, :rating)
    end
end
