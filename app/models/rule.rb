class Rule < ActiveRecord::Base
  belongs_to :group

  validates :gifter, uniqueness: { scope: :recipient, message: "already has this rule!" }
  validate :valid_rule?
  private

  def valid_rule?
    require 'matrix'
    group=Group.find group_id
    santas=group.santa
    gifters=santas.map &:name
    recipients=santas.map &:name
    flag = false
    until gifters.empty? || flag
      dimensions=gifters.length
      gift_matrix=Matrix.build dimensions, dimensions do |row,col|
        if gifters[row]==recipients[col]
          0
        elsif (group.rules.where gifter: group.santa.find_by_name(gifters[row]).name, recipient: group.santa.find_by_name(recipients[col]).name).any?
          0
        elsif gifter==gifters[row] && recipient==recipients[col]
          0
        else
          1
        end
      end
      row_options=Array.new
      for i in 0..gift_matrix.row_count-1 do
        option_count = gift_matrix.row(i).inject(:+)
        flag = true if option_count == 0
        row_options << [option_count,i]
      end
      row_options=row_options.sort_by &:first
      current_gifter=row_options.first.last
      current_recipient=gift_matrix.row(current_gifter).find_index 1
      if flag
        gifters=[]
        gift_matrix=[0]
      else
        gifters.slice! current_gifter
        recipients.slice! current_recipient
      end
    end
    errors.add(:base, "That rule is not valid!") if gift_matrix.first==0
  end
                       
end
