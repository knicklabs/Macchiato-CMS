class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  before_validation :decode_featured_image_data
  
  field :title, type: String
  field :text, type: String
  field :tags, type: Array
  field :published, type: Boolean, default: true

  mount_uploader :featured_image, FeaturedImageUploader
  
  belongs_to :user
  
  embeds_many :meta_names
  embeds_many :custom_fields
  
  accepts_nested_attributes_for :meta_names, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :custom_fields, allow_destroy: true, reject_if: :all_blank
 
  attr_accessible :title, :text, :tags, :published, :meta_names, :meta_names_attributes, :custom_fields, :custom_fields_attributes, :featured_image, :remove_featured_image, :featured_image_data, :featured_image_data_file_name, :featured_image_data_file_type
  attr_accessor :featured_image_data, :featured_image_data_file_name, :featured_image_data_file_type

  default_scope order_by(created_at: "DESC")

  def as_json(options = {})
    attrs = super(options)
    attrs["id"] = attrs["_id"]
    attrs
  end

  private

  class FilelessIO < StringIO
    attr_accessor :original_filename, :content_type
  end

  def featured_image_data_provided?
    !self.featured_image_data.blank?
  end

  def decode_featured_image_data
    if featured_image_data_provided?
      data = FilelessIO.new(Base64.decode64(self.featured_image_data))
      data.original_filename = self.featured_image_data_file_name || 'image.jpg'
      data.content_type = self.featured_image_data_file_type || 'image/jpeg'
      self.featured_image = data
    end
  end
end