class Card < ActiveRecord::Base
  validates :base_url, :presence => true
  belongs_to :user, counter_cache: true
  has_many :tags
  has_many :boxes, through: :tags
  has_and_belongs_to_many :users
  has_many :marks
  has_many :idols, through: :marks
  
  def img_preview_url
    self.upyun_url+self.base_url+"!preview"
  end
  
  def img_standard_url
    self.upyun_url+self.base_url+"!standard"
  end
  
  def img_small_url
    self.upyun_url+self.base_url+"!small"
  end
  
  def img_thumb_url
    self.upyun_url+self.base_url+"!thumbnail"
  end
  
  def img_info_url
    self.upyun_url+self.base_url+"!info"
  end
  
  def card_id
    (self.id + 1000000000).to_s
  end
  
  def reset_from_key
    items = self.key_url.split('/', 8)
    if items[4]
      idol = Idol.find_or_create_by(name: items[3])
      self.idols << idol if idol
      self.pack = items[2] if items[3]
      self.topic = items[4] if items[5]
      self.event = event_space_trim(items[5]) if items[6]
      self.source = items[6] if items[7]
      self.title = "数据来源："+self.source if self.source
      if self.topic
        box_topic = Box.find(name: self.topic)
        if !box_topic
          box_topic = Box.create(name: self.topic, box_type: "topic")
          box_topic.idols << idol
        end
        self.boxes << box_topic
      end
      if self.event
        box_event = Box.find(name: self.event)
        if !box_event
          box_event = Box.create(name: self.event, box_type: "event")
          box_event.idols << idol
        end
        self.boxes << box_event
      end
    end
  end
  
  protected
    def upyun_url
      "http://fanhe-photo.b0.upaiyun.com"
    end
    
    def event_space_trim(str)
      str.slice! 6,1 if str[6] == ' '
      str
    end
  
end