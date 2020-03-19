import Swal from 'sweetalert2';

const updatePatientInfo = () => {
  const btn = document.querySelector('#patient-info-container');
  const form = document.querySelector('#edit-case-form');

  if (btn) {
    btn.addEventListener('click', async (e) => {
      form.style.display = 'unset';

    const {value: output} = await Swal.fire(
    {
      title: 'EDIT PATIENT INFO',
      html: form,
      heightAuto: false,
      focusConfirm: false,
      showConfirmButton: true,
      showCancelButton: true,
      confirmButtonText: 'UPDATE',
      cancelButtonText: 'CANCEL',
      preConfirm: () => {
        Rails.fire(form, 'submit');
      }
    }) // end of Swal
  }); // end of event
  }
};

export { updatePatientInfo };
