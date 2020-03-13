class PresentationsController < ApplicationController
  def index
    @drugs = policy_scope(Drug)
    @admin = current_admin
  end

  def new
    @prensentation = Presentation.new
    authorize @prensentation
  end

  def create
    @presentation = Presentation.new(presentation_params)
    authorize @presentation
    if @presentation.save
      redirect_to drugs_path
    end
  end

  def edit
  end

  def update
  end

  private

  def presentation_params
    params.require(:presentation).permit(:drug_id, :dose, :drug_unit, :volume, :volume_unit)
  end
end
