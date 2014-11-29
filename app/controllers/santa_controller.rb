class SantaController < ApplicationController
  before_action :set_santum, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @santa = Santum.all
    respond_with(@santa)
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
    @santum = Santum.new(santum_params)
    @santum.save
    respond_with(@santum)
  end

  def update
    @santum.update(santum_params)
    respond_with(@santum)
  end

  def destroy
    @santum.destroy
    respond_with(@santum)
  end

  private
    def set_santum
      @santum = Santum.find(params[:id])
    end

    def santum_params
      params.require(:santum).permit(:name, :email, :group_id)
    end
end
