import Sortable from 'sortablejs';
import Swal from 'sweetalert2';



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

// preventOnFilter
// remove clone on hide
// onAdd: function
};

export { activateDrugs };
