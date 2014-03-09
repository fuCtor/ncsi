class Visit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip, default: '0.0.0.0'
  field :comment, default: ''

  belongs_to :computer
end
