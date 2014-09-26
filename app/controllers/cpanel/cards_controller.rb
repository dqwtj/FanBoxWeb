# coding: utf-8
class Cpanel::CardsController < Cpanel::ApplicationController
  
  def index
    user = User.find(params[:user_id]) if params[:user_id]
    box = Box.find(params[:box_id]) if params[:box_id]
    idol = Idol.find(params[:idol_id]) if params[:idol_id]
    @cards = Card.order(created_at: :desc).paginate :page => params[:page], :per_page => 20
    @cards = user.cards.order(created_at: :desc).paginate :page => params[:page], :per_page => 20 if user
    @cards = box.cards.order(created_at: :desc).paginate :page => params[:page], :per_page => 20 if box
    @cards = idol.cards.order(created_at: :desc).paginate :page => params[:page], :per_page => 20 if idol
  end
  
  def new
    @card = Card.new
    @policy = Base64.encode64({:bucket => 'fanhe-photo', :expiration => (Time.now().to_i + 3600), 'save-key' => "/cards/{filemd5}{.suffix}","allow-file-type" =>"jpg,png,jpeg","content-length-range" => "0,20480000"}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'ZLxp3SHTJ1R7flhOVQVWL0YGtdw=')
  end
  
  def create
    
  end
  
  def destroy
    @card = Card.find params[:id]
    
    @card.destroy
    redirect_to cpanel_cards_path, :notice => '卡片删除成功'
  end
  
end