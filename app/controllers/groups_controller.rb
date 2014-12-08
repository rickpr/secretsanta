class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :christmas, :results]

  respond_to :html, :js

  def index
    @groups = current_user.groups.all
    @group = Group.new
    respond_with(@groups)
  end

  def show
    respond_with(@group)
  end

  def new
    @group = Group.new
    respond_with(@group)
  end

  def edit
  end

  def create
    @user = current_user
    @group = @user.groups.new(group_params)
    @group.save
    respond_with(@group)
  end

  def update
    @group.update(group_params)
    respond_with(@group)
  end

  def destroy
    @group.destroy
    respond_with(@group)
  end

  def christmas
    @group.results.destroy_all
    require 'matrix'
    gifters=@group.santa.map &:name
    recipients=@group.santa.map &:name
    results=Hash.new
    until gifters.empty?
      dimensions=gifters.length
      gift_matrix=Matrix.build dimensions, dimensions do |row,col|
        if gifters[row]==recipients[col]
          0
        elsif (@group.rules.where gifter: @group.santa.find_by_name(gifters[row]).name, recipient: @group.santa.find_by_name(recipients[col]).name).any?
          0
        else
          1
        end
      end
      row_options=Array.new
      for i in 0..gift_matrix.row_count-1 do
        row_options << [gift_matrix.row(i).inject(:+),i]
      end
      row_options=row_options.shuffle.sort_by &:first
      current_gifter=row_options.first.last
      ones=Array.new
      gift_matrix.row(current_gifter).each_with_index do |recipient,index|
        ones << index if recipient==1
      end
      current_recipient=ones[rand 0..ones.length-1]
      results[gifters[current_gifter]]=recipients[current_recipient]
      gifters.slice! current_gifter
      recipients.slice! current_recipient
    end
    results.each do |gifter,recipient|
      @group.results.create(gifter: gifter, recipient: recipient)
      @results=@group.results
    end
  end

  def results
  end

  private
    def set_group
      @group = Group.find params[:id]
      redirect_to groups_path, flash: {error:  "That's not your group."} if @group.user.id != current_user.id
    end

    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
