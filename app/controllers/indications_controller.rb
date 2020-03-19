class IndicationsController < ApplicationController
  def index
  end

  def new
    @indication = Indication.new
    authorize @indication
  end

  def create
    @drug = Drug.find(params[:indication][:drug])
    authorize @drug
    @drug.presentations.each do |presentation|
      Indication.create(presentation: presentation, name: params[:indication][:name])
    end
      redirect_to drugs_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def indication_params
    params.require(:indication).permit(:presentation_id, :name)
  end
end
