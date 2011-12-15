class CustomField
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :post
  embedded_in :page
  
  field :key, type: String
  field :value, type: String
  
  attr_accessible :key, :value, :_delete
  
  def as_json(options = {})
    attrs = super(options)
    attrs["id"] = attrs["_id"]
    attrs
  end
end