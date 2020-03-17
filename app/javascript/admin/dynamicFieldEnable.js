const dynamicFieldUpdate = () => {
  const ruleIndication = document.getElementById("rule_indication_id");
  const ruleDrug = document.getElementById("rule_drug");
  const rulePresentation = document.getElementById("rule_presentation_id");
  const ruleRoute = document.getElementById("rule_route_id");
  const rulePatient = document.getElementById("rule_patient_type");
  const calcType = document.getElementById("rule_calc_type");
  const maxInit = document.getElementById("rule_max_initial_dose");
  const minInit = document.getElementById("rule_min_initial_dose");
  const minWeight = document.getElementById("rule_min_weight");
  const maxWeight = document.getElementById("rule_max_weight");
  const maxAge = document.getElementById("rule_max_age");
  const minAge = document.getElementById("rule_min_age");
  const doseUnit = document.getElementById("rule_dose_unit");
  const minInter = document.getElementById("rule_min_interval");
  const maxInter = document.getElementById("rule_max_interval");
  const repeat = document.getElementById("rule_repeat_dose");
  const maxSingle = document.getElementById("rule_max_single_dose");
  const maxTotal = document.getElementById("rule_max_total_dose");

  ruleIndication.addEventListener("change", (event) => {
    if (event.currentTarget.value >= 0 ) {
      console.log("Indication")
      ruleDrug.disabled = false;
      rulePresentation.disabled = false;
    }
  })

  rulePresentation.addEventListener("change", (event) => {
    if (event.currentTarget.value != null && ruleDrug.value != null) {
      console.log("Drug and Presentation")
      ruleRoute.disabled = false;
    }
  })

  ruleRoute.addEventListener("change", (event) => {
    if (event.currentTarget.value != null) {
      console.log("Route")
      rulePatient.disabled = false;
    }
  })

  ruleRoute.addEventListener("change", (event) => {
    if (event.currentTarget.value != null) {
      console.log("Patient_type")
      rulePatient.disabled = false;
    }
  })

  rulePatient.addEventListener("change", (event) => {
    if (event.currentTarget.value === "Adult") {
      console.log("Adult")
      doseUnit.disabled = false;
    } else if (event.currentTarget.value === "Pediatric") {
      console.log("Pediatric")
      calcType.disabled = false;
    }
  })

  calcType.addEventListener("change", (event) => {
    if (event.currentTarget.value === "Age based") {
      minAge.disabled = false;
      maxAge.disabled = false;
    } else if (event.currentTarget.value === "Weight based") {
      minAge.disabled = false;
      maxAge.disabled = false;
      minWeight.disabled = false;
      maxWeight.disabled = false;
    }
  })

  doseUnit.addEventListener("change", (event) => {
      if (event.currentTarget.value != null) {
      minInit.disabled = false;
      maxInit.disabled = false;
    }
  })

  maxInit.addEventListener("change", (event) => {
      if (event.currentTarget.value != null) {
      minInter.disabled = false;
      maxInter.disabled = false;
    }
  })

  maxInter.addEventListener("change", (event) => {
      if (event.currentTarget.value != null) {
      repeat.disabled = false;
    }
  })

  repeat.addEventListener("change", (event) => {
      if (event.currentTarget.value != null) {
      maxSingle.disabled = false;
    }
  })

  maxSingle.addEventListener("change", (event) => {
      if (event.currentTarget.value != null) {
      maxTotal.disabled = false;
    }
  })

}

export { dynamicFieldUpdate }
