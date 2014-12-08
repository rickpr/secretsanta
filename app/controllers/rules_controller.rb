class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:index, :new, :create]


  respond_to :html, :js

  def index
    @rules = @group.rules
    @rule=Rule.new
    respond_with([@group, @rules])
  end

  def create
    @rule = @group.rules.new(rule_params)
    @rule.save
    @group.results.destroy_all
    respond_with([@group, @rule])
  end

  def update
    @rule.update(rule_params)
    respond_with([@group, @rule])
  end

  def destroy
    @rule.destroy
    respond_with([@group, @rule])
  end

  private
    def set_rule
      set_group
      @rule = @group.rules.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
      redirect_to groups_path, flash: {error:  "That's not your group."} if @group.user.id != current_user.id
    end

    def rule_params
      params.require(:rule).permit(:gifter, :recipient, :group_id)
    end
end
