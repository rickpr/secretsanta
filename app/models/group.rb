class Group < ActiveRecord::Base
  belongs_to :user
  has_many :santa
  has_many :rules
  validates :name, presence: true, uniqueness: {scope: :user, case_sensitive: false}
end
