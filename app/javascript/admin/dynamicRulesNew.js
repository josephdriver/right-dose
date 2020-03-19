const dynamicRule = () => {
  const patientType = document.getElementById("rule_patient_type");

  const calcType = document.getElementById("rule_calc_type");

  const minWeight = document.getElementById("rule_min_weight");
  const maxWeight = document.getElementById("rule_max_weight");

  const minAge = document.getElementById("rule_min_age")
  const maxAge = document.getElementById("rule_max_age")

  if (patientType) {
    patientType.addEventListener("change", (event) => {
      if (event.currentTarget.value === "Adult" ) {
        console.log("adult")
        minWeight.style.display = "none";
        minWeight.previousElementSibling.style.display = "none";
        maxWeight.style.display = "none";
        maxWeight.previousElementSibling.style.display = "none";
        calcType.value = "Age based";
        minAge.disabled = false;
        maxAge.disabled = false;
        calcType.readonly = true;
      } else if (event.currentTarget.value === "Pediatric" ) {
        minWeight.style.display = "";
        minWeight.previousElementSibling.style.display = "";
        maxWeight.style.display = "";
        maxWeight.previousElementSibling.style.display = "";
      }
    })
  }
}

export { dynamicRule }
