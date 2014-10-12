# coding: utf-8
class Cpanel::BoxesController < Cpanel::ApplicationController
  
  def index
    idol = Idol.find(params[:idol_id]) if params[:idol_id]
    if idol
      @boxes = idol.boxes.paginate :page => params[:page], :per_page => 30
    else
      @boxes = Box.paginate :page => params[:page], :per_page => 30
    end
  end
  
  def new
    @box = Box.new
  end
  
  def edit
    @box = Box.find params[:id]
  end
  
  def update
    @box = Box.find params[:id]
    
    if @box.update_attributes(params[:box].permit!)
      redirect_to(cpanel_boxes_path, :notice => '话题修改成功')
    else
      render :action => "edit"
    end
  end
  
  
  
end