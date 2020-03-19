const bindDrugInput = () => {
  const info = document.getElementById("info");
    if (info) {
      const presentations = JSON.parse(info.dataset.presentations)
    const drugInput = document.getElementById("rule_drug");

    const presentationsInput = document.getElementById("rule_presentation_id");

    drugInput.addEventListener("change", (event) => {
      const id = event.currentTarget.value;
      const options = presentations[id]
      const stringfiedOptions = createOptions(options);
      presentationsInput.innerHTML = stringfiedOptions;
    })
  }
}

const createOptions = (optionsArray) => {
  let str = `<option value=""></option>`
  optionsArray.forEach((option) => {
    str += `<option value="${option[0]}">${option[1]}</option>`;
  })
  return str
}


export { bindDrugInput }
