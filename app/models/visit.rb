class Visit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip
  field :comment
end
