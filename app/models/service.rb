class Service
  include Mongoid::Document
  embedded_in :user

  field :provider, type: String
  field :uid, type: Integer
  field :info, type: Hash

end
