class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  
  field :title, type: String
  field :text, type: String
  field :tags, type: Array
  field :published, type: Boolean, default: true
  
  belongs_to :user
  
  embeds_many :meta_names
  embeds_many :custom_fields
  
  accepts_nested_attributes_for :meta_names, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :custom_fields, allow_destroy: true, reject_if: :all_blank
 
  attr_accessible :title, :text, :tags, :published, :meta_names, :meta_names_attributes, :custom_fields, :custom_fields_attributes

  default_scope order_by(created_at: "DESC")

  def as_json(options = {})
    attrs = super(options)
    attrs["id"] = attrs["_id"]
    attrs
  end
end