# coding: utf-8
class Cpanel::UsersController < Cpanel::ApplicationController
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 30
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def create
    
    @user = User.new(params[:user].permit!)
    @user.encrypted_password = Digest::MD5.hexdigest(@user.encrypted_password)
    
    if @user.save
      redirect_to(cpanel_users_path, :notice => '用户创建成功')
    else
      render :action => "new"
    end
    
  end
  
  def update
    @user = User.find params[:id]
    
    if @user.update_attributes(params[:user].permit!)
      redirect_to(cpanel_users_path, :notice => '用户修改成功')
    else
      render :action => "edit"
    end
    
  end
  
  def destroy
    @user = User.find params[:id]
    
    @user.destroy
    redirect_to cpanel_users_path, :notice => @user.name + '删除成功'
    
  end
  
end