class Santum < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :name, length: { maximum: 100}
  validates :email, presence: true, email: true
end
