class CaseDrugsController < ApplicationController
  skip_after_action :verify_authorized

  def create

  end

  def index

  end

end


  drugs = Drug.all
  available_drugs = drugs.select do |drug|
      drug.presentations.each do |drug_pres|
        drug_pres.indications.each do |drug_ind|
          drug_ind.rules.each do |drug_rul|
            drug_rul.paramedic_type == current_paramedic
          end
        end
      end
    end
