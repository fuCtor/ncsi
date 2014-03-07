class Visit
  include Mongoid::Document
  include Mongoid::Timestamp

  field :ip
  field :comment
end
