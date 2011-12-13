class User
  include Mongoid::Document
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  
  field :first_name, type: String
  field :last_name, type: String
  field :username, type: String
  
  has_many :posts
  
  validates :first_name, presence: true, length: { maximum: 32 }
  validates :last_name, presence: true, length: { maximum: 32 }
  validates :username, presence: true, length: { minimum: 5, maximum: 16 }
  
  validates_uniqueness_of :username, :email, case_sensitive: false
  
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :remember_me

  def as_json(options = {})
    attrs = super(options)
    attrs["id"] = attrs["_id"]
    attrs
  end
end

