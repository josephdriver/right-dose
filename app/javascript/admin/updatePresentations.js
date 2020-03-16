const bindDrugInput = () => {
  const info = JSON.parse(document.getElementById("info").dataset.presentations);
    if (info) {

    const drugInput = document.getElementById("rule_drug");

    const presentationsInput = document.getElementById("rule_presentation_id");

    drugInput.addEventListener("change", (event) => {
      const id = event.currentTarget.value;
      const options = info[id]
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
