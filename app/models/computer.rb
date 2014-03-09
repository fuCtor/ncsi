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
  has_many :visits

  before_create :generate_key

  def track! ip
    if self.ip != ip
      self.visits.create ip: ip
      self.ip = ip
      self.visited_at = Time.now
      self.save
    else
      self.versionless do |doc|
        doc.visited_at = Time.now
        doc.save
      end
    end
  end

  def generate_key
    self.key = Digest::MD5.hexdigest(SecureRandom.hex + self.id)
  end
end
