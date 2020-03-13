require 'faker'

puts 'Cleaning your database...'
CaseDrug.destroy_all
Case.destroy_all
Paramedic.destroy_all
Rule.destroy_all
Indication.destroy_all
Presentation.destroy_all
Drug.destroy_all
Route.destroy_all
ParamedicType.destroy_all
Admin.destroy_all
Organization.destroy_all

puts 'Building your database...'
ORGANIZATIONS = []

organization = {
  name: 'Le Wagon Ambulance Service',
  location: 'Canggu, Bali',
  pediatric_cutoff: 12,
  multiplier: 3,
  addition_num: 7,
  weight_3mth: 3.5,
  weight_6mth: 7,
  weight_unit: 'kg'
}
ORGANIZATIONS << organization
test_organization = {
  name: 'Test Organization',
  location: 'Canggu, Bali',
  pediatric_cutoff: 12,
  multiplier: 3,
  addition_num: 7,
  weight_3mth: 3.5,
  weight_6mth: 7,
  weight_unit: 'kg'
}
ORGANIZATIONS << test_organization

ORGANIZATIONS.each do |org|
  Organization.create!(org)
  puts "  #{org[:name]} has created an account"
end

ADMINS = []
# LE WAGON ADMIN
first = 'Bob'
last = 'Dylan'
admin_lwas = {
  first_name: first,
  last_name: last,
  email: "#{first}.#{last}@LWAS.com",
  password: 'password',
  employee_num: 0,
  organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
}
ADMINS << admin_lwas
# TEST ORG ADMIN
first_test = 'Test'
last_test = 'Admin'
admin_test = {
  first_name: first_test,
  last_name: last_test,
  email: "#{first_test}.#{last_test}@testorg.com",
  password: 'password',
  employee_num: 0,
  organization_id: Organization.find_by(name: 'Test Organization').id
}
ADMINS << admin_test

ADMINS.each do |admin|
  Admin.create!(admin)
  puts "  #{admin[:first_name]} #{admin[:last_name]} has been named administrator"
end

PARAMEDIC_TYPES = [
  # ACP REFERS TO ACP2
  { title: 'Advanced Care Paramedic',
    acronym: 'ACP',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id },
  { title: 'Critical Care Paramedic',
    acronym: 'CCP',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id },
  { title: 'Patient Transport Service',
    acronym: 'PTS',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id }
]
PARAMEDIC_TYPES.each do |paramedic_type|
  ParamedicType.create!(paramedic_type)
end
puts "\tparamedic types have been established"

ROUTES = [
  { name: 'Nebulizer', acronym: 'NEB' },
  { name: 'Intramuscular injection', acronym: 'IM' },
  { name: 'Intravenous injection', acronym: 'IV' },
  { name: 'Intraosseous injection', acronym: 'IO' },
  { name: 'Intranasal', acronym: 'IN' },
  { name: 'Per oral', acronym: 'PO'}
]

ROUTES.each do |route|
  Route.create!(route)
end
puts "\troutes have been established"

DRUGS = [
  {
    name: 'Adrenaline',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Morphine',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Fentanyl',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Ondansetron',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Glucose 10%',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Midazolam',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  },
  {
    name: 'Naloxone',
    organization_id: Organization.find_by(name: 'Le Wagon Ambulance Service').id
  }
]

DRUGS.each do |drug|
  Drug.create!(drug)
end
puts "\tdrugs have been established"

PRESENTATIONS = [
  {
    dose: 1,
    drug_unit: 'mg',
    volume: 1,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Adrenaline').id
  },
  {
    dose: 1,
    drug_unit: 'mg',
    volume: 10,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Adrenaline').id
  },
  {
    dose: 150,
    drug_unit: 'mcg',
    volume: nil,
    volume_unit: 'EpiPen',
    drug_id: Drug.find_by(name: 'Adrenaline').id
  },
  {
    dose: 300,
    drug_unit: 'mcg',
    volume: nil,
    volume_unit: 'EpiPen',
    drug_id: Drug.find_by(name: 'Adrenaline').id
  },
  {
    dose: 10,
    drug_unit: 'mg',
    volume: 1,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Morphine').id
  },
  {
    dose: 100,
    drug_unit: 'mcg',
    volume: 2,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Fentanyl').id
  },
  {
    dose: 4,
    drug_unit: 'mg',
    volume: 1,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Ondansetron').id
  },
  {
    dose: 250,
    drug_unit: 'ml',
    volume: 250,
    volume_unit: 'ml ViaFlex Bag',
    drug_id: Drug.find_by(name: 'Glucose 10%').id
  },
  {
    dose: 5,
    drug_unit: 'mg',
    volume: 1,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Midazolam').id
  },
  {
    dose: 400,
    drug_unit: 'mcg',
    volume: 1,
    volume_unit: 'ml',
    drug_id: Drug.find_by(name: 'Naloxone').id
  }
]

PRESENTATIONS.each do |presentation|
  Presentation.create!(presentation)
end
puts "\tpresentations have been established"

def find_presentation(drug)
  # puts "#{drug} CANNOT BE FOUND!" if Drug.find_by(name: drug).nil?
  tmp = Drug.find_by(name: drug).id
  Presentation.find_by(drug_id: tmp).id
end

INDICATIONS = [
  {
    name: 'Cardiac arrest',
    # drug_id: Drug.find_by(name: 'Adrenaline'),
    presentation_id: find_presentation('Adrenaline')
  },
  {
    name: 'Anaphylaxis OR severe allergic reaction',
    # drug_id: Drug.find_by(name: 'Adrenaline'),
    presentation_id: find_presentation('Adrenaline')
  },
  {
    name: 'Severe life-threatening bronchospasm OR silent chest',
    # drug_id: Drug.find_by(name: 'Adrenaline'),
    presentation_id: find_presentation('Adrenaline')
  },
  {
    name: 'Shock unresponsive to adequate fluid resuscitation',
    # drug_id: Drug.find_by(name: 'Adrenaline'),
    presentation_id: find_presentation('Adrenaline')
  },
  {
    name: 'Bradycardia',
    # drug_id: Drug.find_by(name: 'Adrenaline'),
    presentation_id: find_presentation('Adrenaline')
  },

  {
    name: 'Significant pain',
    # drug_id: Drug.find_by(name: 'Morphine'),
    presentation_id: find_presentation('Morphine')
  },
  {
    name: 'Autonomic dysreflexia',
    # drug_id: Drug.find_by(name: 'Morphine'),
    presentation_id: find_presentation('Morphine')
  },
  {
    name: 'Sedation',
    # drug_id: Drug.find_by(name: 'Morphine'),
    presentation_id: find_presentation('Morphine')
  },

  {
    name: 'Significant pain',
    # drug_id: Drug.find_by(name: 'Fentanyl'),
    presentation_id: find_presentation('Fentanyl')
  },
  {
    name: 'Autonomic dysreflexia',
    # drug_id: Drug.find_by(name: 'Fentanyl'),
    presentation_id: find_presentation('Fentanyl')
  },
  {
    name: 'Sedation',
    # drug_id: Drug.find_by(name: 'Fentanyl'),
    presentation_id: find_presentation('Fentanyl')
  },
  {
    name: 'Rapid Sequence Intubation (RSI)',
    # drug_id: Drug.find_by(name: 'Fentanyl'),
    presentation_id: find_presentation('Fentanyl')
  },

  {
    name: 'Significant nausea AND/OR vomiting',
    # drug_id: Drug.find_by(name: 'Ondansetron'),
    presentation_id: find_presentation('Ondansetron')
  },

  {
    name: 'Symptomatic hypoglycemia',
    # drug_id: Drug.find_by(name: 'Glucose 10%'),
    presentation_id: find_presentation('Glucose 10%')
  },

  {
    name: 'Generalised seizure/focal seizure',
    # drug_id: Drug.find_by(name: 'Midazolam'),
    presentation_id: find_presentation('Midazolam')
  },
  {
    name: 'Generalised seizure',
    # drug_id: Drug.find_by(name: 'Midazolam'),
    presentation_id: find_presentation('Midazolam')
  },
  {
    name: 'Sedation',
    # drug_id: Drug.find_by(name: 'Midazolam'),
    presentation_id: find_presentation('Midazolam')
  },
  {
    name: 'Acute behavioral disturbance',
    # drug_id: Drug.find_by(name: 'Midazolam'),
    presentation_id: find_presentation('Midazolam')
  },

  {
    name: 'Respiratory depression',
    # drug_id: Drug.find_by(name: 'Naloxone'),
    presentation_id: find_presentation('Naloxone')
  }
]

INDICATIONS.each do |indication|
  Indication.create!(indication)
end
puts "\tindications have been established"

def find_indication(indication, drug)
  puts "#{drug} could not be found" if Drug.find_by(name: drug).nil?
  puts "#{indication} could not be found" if Indication.find_by(name: indication).nil?

  tmp = find_presentation(drug)
  Indication.where(name: indication).find_by(presentation_id: tmp).id
end

# IF TIME OR DOSE IS NOT A RANGE, THE DOSE/TIME IS SET BY THE MAX_VALUE
RULES = [
  # ADRENALINE
  # ADULT DOSAGES
    # CARDIAC ARREST
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },
    # Anaphylaxis OR SEVERE ALLERGIC REACTION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 'Single dose only',
    max_single_dose: 300,
    max_total_dose: 300
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
    # SEVERE LIFE-THREATENING BRONCHOSPASM OR SILENT CHEST
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
    # BRADYCARDIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Bradycardia', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 1,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 20,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  # PAEDIATRIC DOSAGES
    # CARDIAC ARREST
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: 10,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 10,
    repeat_dose: 10,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: 10,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: 10,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 10,
    repeat_dose: 10,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: 10,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: 10,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
    # ANAPHLAXIS OR SEVERE ALLERGIC REACTION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 'Single dose only',
    max_single_dose: 300,
    max_total_dose: 300
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 6,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 'Single dose only',
    max_single_dose: 150,
    max_total_dose: 150
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 6,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0.5,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0,
    max_age: 0.5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 6,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0.5,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0,
    max_age: 0.5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
    # SEVERE LIFE-THREATENING BROCHOSPASM OR SILENT CHEST
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 6,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0.5,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0,
    max_age: 0.5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 6,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0.5,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Severe life-threatening bronchospasm OR silent chest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 0,
    max_age: 0.5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  # MORPHINE
  # ADULT DOSAGES
    # SIGNIFICANT PAIN
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 'No maximum dose'
  },
    # AUTONOMIC DYSREFLEXIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  # PAEDIATRIC DOSAGES
    # SIGNIFICANT PAIN
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 100,
    max_initial_dose: 200,
    repeat_dose: 'Single dose only',
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
    # AUTONOMIC DYSREFLEXIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 100,
    max_initial_dose: 200,
    repeat_dose: 'Single dose only',
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Morphine'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
  # FENTANYL
  # ADULT DOSAGES
    # SIGNIFICANT PAIN
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
    # AUTONOMIC DYSREFLEXIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 50,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 25,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 25,
    repeat_dose: 25,
    max_single_dose: 25,
    max_total_dose: 'No maximum dose'
  },
  # PAEDIATRIC DOSAGES
    # SIGNIFICANT PAIN
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min - ONCE',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1.5,
    repeat_dose: 1,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 0.5,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min - ONCE',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1.5,
    repeat_dose: 1,
    max_single_dose: 50,
    max_total_dose: 100
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2,
    repeat_dose: 'Single dose only',
    max_single_dose: 50,
    max_total_dose: 2
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min - ONCE',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2,
    repeat_dose: 1,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min - ONCE',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 0.5,
    max_single_dose: 25,
    max_total_dose: 2
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min - ONCE',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 0.5,
    max_single_dose: 25,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 1,
    max_single_dose: 25,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Fentanyl'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    repeat_dose: 1,
    max_single_dose: 25,
    max_total_dose: 'No maximum dose'
  },
  # ONDASETRON
  # ADULT DOSAGES
    # SIGNIFICANT NAUSEA AND/OR VOMITING
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'PO').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'PO').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 4,
    max_initial_dose: 8,
    repeat_dose: nil,
    max_single_dose: nil,
    max_total_dose: 8
  },
  # PAEDIATRIC DOSAGES
    # SIGNIFICANT NAUSEAU AND/OR VOMITING
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'PO').id,
    min_age: 5,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 4,
    repeat_dose: 'Single dose only',
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'PO').id,
    min_age: 5,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 4,
    repeat_dose: 'Single dose only',
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 5,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2,
    repeat_dose: 'Single dose only',
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 3,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 'Single dose only',
    max_single_dose: 4000,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 3,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 'Single dose only',
    max_single_dose: 4000,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 3,
    max_age: 12,
    min_interval: 2,
    max_interval: 3,
    interval_unit: 'min - PUSH SLOWLY',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 'Single dose only',
    max_single_dose: 4000,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant nausea AND/OR vomiting', 'Ondansetron'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 3,
    max_age: 12,
    min_interval: 2,
    max_interval: 3,
    interval_unit: 'min - PUSH SLOWLY',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 'Single dose only',
    max_single_dose: 4000,
    max_total_dose: nil
  },
  # GLUCOSE 10%
  # ADULT DOSAGES
    # SYMPTOMATIC HYPOGLYCEMIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 100,
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 100,
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    repeat_dose: 100,
    max_single_dose: nil,
    max_total_dose: nil
  },
  # PAEDIATRIC DOSAGES
    # SYMPTOMATIC HYPO GLYCEMIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Symptomatic hypoglycemia', 'Glucose 10%'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: nil,
    max_total_dose: nil
  },
  # MIDAZOLAM
  # ADULT DOSAGES
    # GENERALIZED SEIZURE/FOCAL SEIZURE
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 70,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 4,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 4,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
    # ACUTE BEHAVIORAL DISTURBANCE
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Acute behavioral disturbance', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 4,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Acute behavioral disturbance', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: 13,
    max_age: nil,
    min_interval: 3,
    max_interval: 4,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 1,
    max_initial_dose: 2.5,
    repeat_dose: 1,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  # PAEDIATRIC DOSAGES
    # GENERALISED SEIZURES/FOCAL SEIZURE
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IN').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Generalised seizure/focal seizure', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 10_000
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: nil,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 5000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: nil,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 5000
  },
    # ACUTE BEHAVIORAL DISTURBANCE
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Acute behavioral disturbance', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: nil,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 5000
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Acute behavioral disturbance', 'Midazolam'),
    route_id: Route.find_by(acronym: 'IO').id,
    min_age: nil,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 5000
  },
  # NALOXONE
  # ADULT DOSAGES
    # RESPIRATORY DEPRESSION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Respiratory depression', 'Naloxone'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1.6,
    repeat_dose: 'Single dose only',
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Respiratory depression', 'Naloxone'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1.6,
    repeat_dose: 'Single dose only',
    max_single_dose: nil,
    max_total_dose: nil
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Respiratory depression', 'Naloxone'),
    route_id: Route.find_by(acronym: 'IV').id,
    min_age: 13,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 50,
    repeat_dose: 50,
    max_single_dose: 50,
    max_total_dose: 'No maximum dose'
  },

  # PAEDIATRIC DOSAGES
    # RESPIRATORY DEPRESSION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Respiratory depression', 'Naloxone'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 20,
    repeat_dose: 'Single dose only',
    max_single_dose: 800,
    max_total_dose: 800
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Respiratory depression', 'Naloxone'),
    route_id: Route.find_by(acronym: 'IM').id,
    min_age: nil,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 20,
    repeat_dose: 'Single dose only',
    max_single_dose: 800,
    max_total_dose: 800
  }
]

RULES.each do |rule|
  rule[:min_weight] && rule[:max_weight] ? rule[:calc_type] = 'age' : rule[:calc_type] = 'weight'
  Rule.create!(rule)
end
puts "\trules have been established"

PARAMEDICS = []
# CONSTANT PARAMEDICS FOR TESTING
medic_acp = {
  first_name: 'ACP',
  last_name: 'Medic',
  email: 'ACP.Medic@LWAS.com',
  password: 'password',
  paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id
}
PARAMEDICS << medic_acp
medic_ccp = {
  first_name: 'CCP',
  last_name: 'Medic',
  email: 'CCP.Medic@LWAS.com',
  password: 'password',
  paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id
}
PARAMEDICS << medic_ccp
medic_pts= {
  first_name: 'PTS',
  last_name: 'Medic',
  email: 'PTS.Medic@LWAS.com',
  password: 'password',
  paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id
}
PARAMEDICS << medic_pts

10.times do
  first = Faker::Name.first_name
  last = Faker::Name.last_name

  paramedic = {
    first_name: first,
    last_name: last,
    email: "#{first}.#{last}@LWAS.com",
    password: 'password',
    # employee_num: 6.times.map { (0..9).to_a.sample }.join.to_i,
    paramedic_type_id: ParamedicType.all.sample.id
  }

  PARAMEDICS << paramedic
end

PARAMEDICS.each do |paramedic|
  medic = Paramedic.create(paramedic)
  medic.employee_num = medic.id
  medic.save!
  puts "  #{medic.first_name} #{medic.last_name} has been added as a paramedic"
end
puts "\tparamedics have been established"

# CASES = []
# CASES.each do |tmp|
#   Case.create!(tmp)
# end
# puts "\tcases have been established"

# CASE_DRUGS = []
# CASE_DRUGS.each do |case_drug|
#   CaseDrug.create!(case_drug)
# end
# puts "\tcase drugs have been established"
puts "DATABASE SEED COMPLETE!!"
