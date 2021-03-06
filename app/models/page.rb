class Page 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  
  field :title, type: String
  field :text, type: String
  field :published, type: Boolean, default: true
  field :parent_id, type: Integer, default: 0
  
  belongs_to :user
  
  embeds_many :meta_names
  embeds_many :custom_fields
  
  accepts_nested_attributes_for :meta_names, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :custom_fields, allow_destroy: true, reject_if: :all_blank
  
  def as_json(options = {})
    attrs = super(options)
    attrs["id"] = attrs["_id"]
    attrs
  end
end