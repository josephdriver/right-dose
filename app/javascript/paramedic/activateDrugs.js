import Sortable from 'sortablejs';
import Swal from 'sweetalert2';

const createOptions = (optionsArray) => {
  let str = `<option value=""></option>`
  optionsArray.forEach((option) => {
    str += `<option value="${option[0]}">${option[1]}</option>`;
  })
  return str
}

const populateForm = () => {
  const rules = JSON.parse(document.getElementById("rules-json").innerText);
  let presentationInput = document.getElementById("case-drug-presentation");
  let indicationInput = document.getElementById("case-drug-indication");
  let routeInput = document.getElementById("case-drug-route");

  presentationInput.addEventListener("change", (event) => {
    console.log(event.currentTarget.value);
    if (event.currentTarget.value != null) {
      console.log(event.currentTarget.value)
      indicationInput.style.disabled = false;

      const options = rules.forEach(element => {
        if (event.currentTarget.value === element.indication.presentation)
          console.log(element.indication.presentation)
      });
    }
  })

}

async function populateDrugs() {
  const form = document.querySelector('#case-drug-form');

  form.style.display = 'unset';
  const {value: output} = await Swal.fire(
  {
    title: 'ENTER DRUG INFORMATION',
    html: form,
    heightAuto: false,
    focusConfirm: false,
    showConfirmButton: true,
    showCancelButton: true,
    confirmButtonText: 'CREATE',
    cancelButtonText: 'CANCEL',
    onOpen: () => {
      console.log('opened!');
      populateForm();
    },
    preConfirm: () => {
      Rails.fire(form, 'submit');
    }
  }) // end of Swal
}

const activateDrugs = () => {
  const drugs = document.querySelector('#myUL');
  const activeContainer = document.querySelector('.active-container');

  Sortable.create(drugs, {
      group: {
          name: 'shared',
          pull: 'clone',
          put: false // Do not allow items to be put into this list
      },
      animation: 150,
      sort: false // To disable sorting: set sort to false
  });

  Sortable.create(activeContainer, {
      group: 'shared',
      animation: 150,
      onAdd: function(event){
        const item = event.item;
        item.style.display = 'none';
        populateDrugs();
      }
  });
};

export { activateDrugs };
