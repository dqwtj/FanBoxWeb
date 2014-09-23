# coding: utf-8
class Cpanel::IdolsController < Cpanel::ApplicationController
  
  def index
    @idols = Idol.paginate :page => params[:page], :per_page => 30
  end
  
  def new
    @idol = Idol.new
  end
  
  def edit
    @idol = Idol.find params[:id]
  end
  
  def create
    
    @idol = Idol.new(params[:idol])
    @idol.encrypted_password = Digest::MD5.hexdigest(@idol.encrypted_password)
    
    if @idol.save
      redirect_to(cpanel_idols_path, :notice => '用户创建成功')
    else
      render :action => "new"
    end
    
  end
  
  def update
    
  end
  
end