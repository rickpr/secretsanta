class Rule < ActiveRecord::Base
  belongs_to :group

  validates :recipient, uniqueness: { scope: :gifter,
      message: "That rule already exists." }
  validate :valid_rule?
  private

  def valid_rule?
    require 'matrix'
    group=Group.find(group_id)
    santas=group.santa
    dimensions=santas.length
    if gifter==recipient
      errors.add(:base, gifter + " cannot self-gift!")
    else
      rule_matrix=Matrix.build(dimensions, dimensions) do |row,col|
        if row == col
          0
        elsif (group.rules.where gifter: santas[row].name, recipient: santas[col].name).any?
          0
        elsif gifter == santas[row].name && recipient == santas[col].name
          0
        else
          1
        end
      end
      errors.add(:base, "You have set too many rules") if rule_matrix.singular?
    end
  end
                       
end
