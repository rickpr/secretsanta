class Rule < ActiveRecord::Base
  belongs_to :group

  validate :valid_rule?

  private

  def valid_rule?
    santa=Group.find(group_id).santa
    dimensions=santa.length
    a=Matrix.build(dimensions, dimensions) { |row,col| row == col || (@group.Rules.where gifter: santa[row].name, recipient: santa[col].name).any? ? false : true }
    !a.singular? # Tests for a singular matrix
  end
                       
end
