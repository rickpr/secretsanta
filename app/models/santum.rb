class Santum < ActiveRecord::Base
  belongs_to :group
  validates :name, presence: true, length: { maximum: 100}, uniqueness: {scope: :group, case_sensitive: false}
  validates :email, presence: true, email: true, uniqueness: {scope: :group, case_sensitive: false}
end
