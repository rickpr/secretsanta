class Santum < ActiveRecord::Base
  belongs_to :group
  has_many :rules
end
