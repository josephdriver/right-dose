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
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    dose_unit: 'mcg',
    repeat_dose: 'Single dose only',
    max_single_dose: 300,
    max_total_dose: 300
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    dose_unit: 'mcg',
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 500,
    dose_unit: 'mcg',
    repeat_dose: 500,
    max_single_dose: 500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },

  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    dose_unit: 'mcg',
    repeat_dose: 'Single dose only',
    max_single_dose: 300,
    max_total_dose: 300
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'PTS').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 1,
    max_age: 5,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    dose_unit: 'mcg',
    repeat_dose: 'Single dose only',
    max_single_dose: 150,
    max_total_dose: 150
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    dose_unit: 'mcg',
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 1,
    max_age: 5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'mins',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    dose_unit: 'mcg',
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },

  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 6,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 300,
    dose_unit: 'mcg',
    repeat_dose: 300,
    max_single_dose: 300,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 1,
    max_age: 5,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 150,
    dose_unit: 'mcg',
    repeat_dose: 150,
    max_single_dose: 150,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 1,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Anaphylaxis OR severe allergic reaction', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'NEB').id,
    patient_type: 'Pediatric',
    calc_type: 'Age based',
    min_age: 0,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5,
    max_total_dose: 5
  },
    # SEVERE LIFE-THREATENING BRONCHOSPASM OR SILENT CHEST

  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    dose_unit: 'mg',
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    dose_unit: 'mg',
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IO').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 1,
    dose_unit: 'mg',
    repeat_dose: 1,
    max_single_dose: 1,
    max_total_dose: 'No maximum dose'
  },

  # PAEDIATRIC DOSAGES
    # CARDIAC ARREST
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: 10,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 10,
    dose_unit: 'mcg',
    repeat_dose: 10,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: 10,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 10,
    dose_unit: 'mcg',
    repeat_dose: 10,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 0,
    max_age: 1,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: 10,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Cardiac arrest', 'Adrenaline'),
    route_id: Route.find_by(acronym: 'IO').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 0,
    max_age: 1,
    min_interval: 3,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: 10,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 100,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: 70,
    max_age: 99,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: nil,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: 70,
    max_age: 99,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    dose_unit: 'mg',
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Weight based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 'No maximum dose'
  },
    # AUTONOMIC DYSREFLEXIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: 70,
    max_age: 99,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: 13,
    max_age: 70,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 10,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 10,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: 70,
    max_age: 99,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    dose_unit: 'mg',
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 10
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: 70,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 20
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 2.5,
    max_initial_dose: 5,
    dose_unit: 'mg',
    repeat_dose: 5,
    max_single_dose: 5,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    dose_unit: 'mg',
    repeat_dose: 2.5,
    max_single_dose: 2.5,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IO').id,
    patient_type: 'Adult',
    calc_type: 'Age based',
    min_age: nil,
    max_age: nil,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 2.5,
    dose_unit: 'mg',
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
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 100,
    max_initial_dose: 200,
    dose_unit: 'mcg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Significant pain', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
    # AUTONOMIC DYSREFLEXIA
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: 100,
    max_initial_dose: 200,
    dose_unit: 'mcg',
    repeat_dose: 'Single dose only',
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IM').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 10,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 200,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 5000,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'ACP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 200
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Autonomic dysreflexia', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: 5,
    interval_unit: 'min',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 50,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
    # SEDATION
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Morphine'),
    route_id: Route.find_by(acronym: 'IV').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
  {
    paramedic_type_id: ParamedicType.find_by(acronym: 'CCP').id,
    indication_id: find_indication('Sedation', 'Morphine'),
    route_id: Route.find_by(acronym: 'IO').id,
    patient_type: 'Pediatric',
    calc_type: 'Weight based',
    min_age: 1,
    max_age: 12,
    min_interval: nil,
    max_interval: nil,
    interval_unit: 'PRN',
    min_weight: nil,
    max_weight: nil,
    min_initial_dose: nil,
    max_initial_dose: 100,
    dose_unit: 'mcg',
    repeat_dose: 100,
    max_single_dose: 2500,
    max_total_dose: 'No maximum dose'
  },
]

RULES.each do |rule|
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
