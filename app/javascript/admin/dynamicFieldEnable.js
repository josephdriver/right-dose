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
  const createRule = document.getElementById("create_rule");

  if (ruleDrug.value != "") {
    ruleDrug.disabled = false
  }

  if (rulePresentation.value != "") {
    rulePresentation.disabled = false
  }

  if (ruleRoute.value != "") {
  }

  if (rulePatient.value != "") {
    rulePatient.disabled = false
  }

  if (ruleDrug.value != "") {
    ruleDrug.disabled = false
  }

  if (ruleDrug.value != "") {
    ruleDrug.disabled = false
  }

  if (rulePatient.value != "") {
    rulePatient.disabled = false
  }

  if (calcType.value != "") {
    calcType.disabled = false
  }

  if (minInit.value != "") {
    minInit.disabled = false
  }

  if (maxInit.value != "") {
    maxInit.disabled = false
  }

  if (doseUnit.value != "") {
    doseUnit.disabled = false
  }

  if (minInter.value != "") {
    minInter.disabled = false
  }

  if (maxInter.value != "") {
    maxInter.disabled = false
  }

  if (repeat.value != "") {
    repeat.disabled = false
  }

  if (maxSingle.value != "") {
    maxSingle.disabled = false
  }

  if (maxTotal.value != "") {
    maxTotal.disabled = false
  }

  if (minAge.value != "") {
    minAge.disabled = false
  }

  if (maxAge.value != "") {
    maxAge.disabled = false
  }

  if (minWeight.value != "") {
    minWeight.disabled = false
  }

  if (maxWeight.value != "") {
    maxWeight.disabled = false
  }

  ruleIndication.addEventListener("change", (event) => {
    if (event.currentTarget.value != "" ) {
      console.log("Indication")
      ruleDrug.disabled = false;
      rulePresentation.disabled = false;
    }
  })

  rulePresentation.addEventListener("change", (event) => {
    if (event.currentTarget.value != "" && ruleDrug.value != "") {
      console.log("Drug and Presentation")
      ruleRoute.disabled = false;
    }
  })

  ruleRoute.addEventListener("change", (event) => {
    if (event.currentTarget.value != "") {
      console.log("Route")
      rulePatient.disabled = false;
    }
  })

  ruleRoute.addEventListener("change", (event) => {
    if (event.currentTarget.value != "") {
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
      minWeight.disabled = false;
      maxWeight.disabled = false;
      minInit.previousElementSibling.innerText = "Min Initial Dose";
      maxInit.previousElementSibling.innerText = "Max Initial Dose*";
      repeat.previousElementSibling.innerText = "Repeat Dose";
      maxSingle.previousElementSibling.innerText = "Max Single Dose";
      maxTotal.previousElementSibling.innerText = "Max Total Dose*";
    } else if (event.currentTarget.value === "Weight based") {
      minAge.disabled = false;
      maxAge.disabled = false;
      minWeight.disabled = false;
      maxWeight.disabled = false;
      minInit.previousElementSibling.innerText = "Min Initial Dose/kg";
      maxInit.previousElementSibling.innerText = "Max Initial Dose/<keygen />";
      repeat.previousElementSibling.innerText = "Repeat Dose/kg";
      maxSingle.previousElementSibling.innerText = "Max Single Dose/kg*";
      maxTotal.previousElementSibling.innerText = "Max Total Dose/kg";
    }
  })

  maxAge.addEventListener("change", (event) => {
    if (event.currentTarget.value != "") {
      doseUnit.disabled = false;
    }
  })

  doseUnit.addEventListener("change", (event) => {
      if (event.currentTarget.value != "") {
      minInit.disabled = false;
      maxInit.disabled = false;
    }
  })

  maxInit.addEventListener("change", (event) => {
      if (event.currentTarget.value != "") {
      minInter.disabled = false;
      maxInter.disabled = false;
      maxSingle.disabled = false;
    }
  })

  maxInter.addEventListener("change", (event) => {
      if (event.currentTarget.value != "") {
      repeat.disabled = false;
    }
  })

  repeat.addEventListener("change", (event) => {
      if (event.currentTarget.value != "") {
      maxSingle.disabled = false;
    }
  })

  maxSingle.addEventListener("change", (event) => {
      if (event.currentTarget.value != "") {
      maxTotal.disabled = false;
      createRule.disabled = false;
    }
  })
}

export { dynamicFieldUpdate }
