class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @rules = Rule.all
    respond_with(@rules)
  end

  def show
    respond_with(@rule)
  end

  def new
    @rule = Rule.new
    respond_with(@rule)
  end

  def edit
  end

  def create
    @rule = Rule.new(rule_params)
    @rule.save
    respond_with(@rule)
  end

  def update
    @rule.update(rule_params)
    respond_with(@rule)
  end

  def destroy
    @rule.destroy
    respond_with(@rule)
  end

  private
    def set_rule
      @rule = Rule.find(params[:id])
    end

    def rule_params
      params.require(:rule).permit(:gifter, :recipient, :santa_id)
    end
end
