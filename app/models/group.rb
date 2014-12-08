class Group < ActiveRecord::Base
  belongs_to :user
  has_many :santa, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :results, dependent: :destroy
  validates :name, presence: true, uniqueness: {scope: :user, case_sensitive: false}
end
