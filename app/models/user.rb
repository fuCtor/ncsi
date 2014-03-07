class User
  include Mongoid::Document
  rolify

  devise :trackable, :omniauthable, :timeoutable

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :key

  embeds_many :services

  has_many :computers

  before_create :generate_key

  def avatar
    service = get_service
    service['info']['image'] rescue nil
  end

  def name
    service = get_service
    service['info']['name'] rescue nil
  end

  def self.find_for_oauth(auth, signed_in_resource=nil)

    provider = auth.provider.to_s
    uid = auth.uid.to_i

    user = self.where('services.provider' => provider, 'services.uid' => uid ).first  || create

    user.update_provider provider, uid, auth.info
    user
  end

  def update_provider(provider, id, info)
    service = services.select {|s| s.provider == provider && s.uid == id }.first
    if service
      service.info = info
      service.save
    else
      service = register_provider provider, id, info
    end
    service
  end

  protected

  def get_service
    @service ||= services.first
  end

  def generate_key
    self.key = Digest::MD5.hexdigest(SecureRandom.hex + self.id)
  end

  def register_provider(provider, id, info)
    services.create provider: provider, uid: id, info: info
  end
end
