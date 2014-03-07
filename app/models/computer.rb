class Computer
  include Mongoid::Document
  include Mongoid::Versioning

  max_versions 5

  resourcify

  field :name, default: ''
  field :ip, default: '0.0.0.0'
  field :key
  field :visited_at, default: Time.now

  field :comment, default: ''

  belongs_to :user

  before_create :generate_key

  def generate_key
    self.key = Digest::MD5.hexdigest(SecureRandom.hex + self.id)
  end
end
