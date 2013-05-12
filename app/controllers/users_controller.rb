class UsersController < ApplicationController
  before_filter :signed_user, only: [:index]
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user])
    if @user.save
      flash[:success] = "User '#{@user.first_name} #{@user.last_name}' created "
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
     @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="User '#{@user.first_name} #{@user.last_name}' has been updated "
      redirect_to users_path
    else
      render "edit"
    end
  end

  def index
    @users=User.paginate(page: params[:page])
  end

  def destroy
    if User.find(params[:id]).last_name != "Ziryanov" && User.find(params[:id]).last_name != "Base"
      #разрешаем удалять всех кромме админов Зырянов и Base
      User.find(params[:id]).destroy
      flash[:success] = "User has been destroyed"
      redirect_to users_path
    else
      flash[:error] = "Don't try to destroy general Admin"
      redirect_to users_path
    end
  end

  private

  def admin_user
    redirect_to root_path unless signed_in? && current_user.admin?
  end

  def signed_user
    redirect_to root_path unless signed_in?
  end

end
