class CustomersController < ApplicationController
    before_filter :signed_in_user # см. AplicationController

  def new
    @customer = Customer.new
  end

  def create
     @customer=Customer.new(params[:customer])
     @customer.who_updated = current_user.last_name
    if @customer.save
      flash[:success] = "Customer '#{@customer.first_name} #{@customer.last_name}' created "
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    @customer.who_updated = current_user.last_name
    if @customer.update_attributes(params[:customer])
      flash[:success]="Customer '#{@customer.first_name} #{@customer.last_name}' has been updated "
      redirect_to customers_path
    else
      render "edit"
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @updated_user = User.find_by_last_name(@customer.who_updated)
  end

  def index
    @find_customer = Customer.new
    @customers = Customer.paginate(page: params[:page], per_page: 10)
  end

  def destroy
      Customer.find(params[:id]).destroy
      flash[:success] = "Customer has been destroyed"
      redirect_to customers_path
  end

  def find
  
    @customers = Customer.where("first_name=? OR last_name=? OR middle_name=?", params[:find_customer][:first_name], params[:find_customer][:last_name], params[:find_customer][:middle_name]).paginate(page: params[:page], per_page: 10)
    if @customers[0].nil?
      flash[:success] = "Nothing was found"
      @customers = Customer.paginate(page: params[:page], per_page: 10)
      @find_customer = Customer.new
      redirect_to customers_path and return
    else
      @find_customer = Customer.new
      render 'index'
    end
  end
end
