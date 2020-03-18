module DashboardsHelper
  def paramedic_rules_to_json(drug)
    @rules = []
    drug.rules.where(paramedic_type_id: current_paramedic.paramedic_type_id).each do |rule|
      @rules << {
        id: rule.id,
        paramedic_type: {
          id: rule.paramedic_type.id,
          acronym: rule.paramedic_type.acronym,
          title: rule.paramedic_type.title,
          organization: {
            id: rule.paramedic_type.organization.id,
            name: rule.paramedic_type.organization.name }  },
        route: {
          id: rule.route.id,
          acronym: rule.route.acronym,
          name: rule.route.name },
        indication: {
          id: rule.indication.id,
          name: rule.indication.name,
          presentation: {
            id: rule.indication.presentation.id,
            dose: rule.indication.presentation.dose,
            drug_unit: rule.indication.presentation.drug_unit,
            volume: rule.indication.presentation.volume,
            volume_unit: rule.indication.presentation.volume_unit,
            drug: {
              id: rule.indication.presentation.drug.id,
              name: rule.indication.presentation.drug.name
            } } },
        min_age: rule.min_age,
        max_age: rule.max_age,
        repeat_dose: rule.repeat_dose,
        min_interval: rule.min_interval,
        max_interval: rule.max_interval,
        min_weight: rule.min_weight,
        max_weight: rule.max_weight,
        calc_type: rule.calc_type,
        interval_unit: rule.interval_unit,
        max_initial_dose: rule.max_initial_dose,
        min_initial_dose: rule.min_initial_dose,
        max_single_dose: rule.max_single_dose,
        max_total_dose: rule.max_total_dose,
        dose_unit: rule.dose_unit,
        patient_type: rule.patient_type }
    end
    @rules.to_json
  end
end
