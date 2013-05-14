class MessagesController < ApplicationController
  before_filter :signed_user
  
  def new
    @user = User.find(params[:id])
    @message = @user.messages.build
    @old_content = "#{params[:content]} \nEND OF MESSAGE\n"
  end

  def create
    @message = Message.new(params[:message])
  	@message.who_sent = current_user.last_name
  	if @message.save
  		flash[:success] = "Message has been sent"
  		redirect_to users_path
  	else
  		render "new"
  	end
  end

  def destroy
    message = Message.find(params[:id])
    if !message.nil?
      message.destroy 
      flash[:success] = "Message deleted"   
      redirect_to mymessages_path
    else 
      flash[:error] = "Message wasn't found"   
      redirect_to mymessages_path
    end
  end

  def index
    if signed_in?
      @messages = Message.where("user_id=?", current_user.id).paginate(page: params[:page], per_page: 10)
    else
      @messages = []
    end
  end

  private

    def signed_user
      redirect_to root_path unless signed_in?
    end

end
