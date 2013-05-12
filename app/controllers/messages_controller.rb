class MessagesController < ApplicationController
  def new
    @user = User.find(params[:id])
    @message = @user.messages.build
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
  end
end
