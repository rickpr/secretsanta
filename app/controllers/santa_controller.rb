class SantaController < ApplicationController
  before_action :set_santum, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:index, :new, :create]

  respond_to :html

  def index
    @santa=@group.santa
    respond_with([@group, @santa])
  end

  def show
    respond_with(@santum)
  end

  def new
    @santum = Santum.new
    respond_with(@santum)
  end

  def edit
  end

  def create
    @santum = @group.santa.new(santum_params)
    @santum.save
    respond_with([@group, @santum])
  end

  def update
    @santum.update(santum_params)
    respond_with([@group, @santum])
  end

  def destroy
    @santum.destroy
    respond_with(@santum)
  end

  private
    def set_santum
      set_group
      @santum = @group.santa.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def santum_params
      params.require(:santum).permit(:name, :email, :group_id)
    end
end
