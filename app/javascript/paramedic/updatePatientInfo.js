import Swal from 'sweetalert2';

const updatePatientInfo = () => {
  const btn = document.querySelector('#patient-info-container');
  const form = document.querySelector('#edit-case-form');

  btn.addEventListener('click', async (e) => {
    form.style.display = 'unset';

    const {value: output} = await Swal.fire(
    {
      title: 'EDIT PATIENT INFO',
      html: form,
      focusConfirm: false,
      showConfirmButton: true,
      showCancelButton: true,
      confirmButtonText: 'UPDATE',
      cancelButtonText: 'CANCEL',
      preConfirm: () => {
        const age = parseInt(document.getElementById('input-age').value);
        const weight = parseInt(document.getElementById('input-weight').value);
        const submit = document.getElementById('input-submit-btn');
        Rails.fire(form, 'submit');
        return [ age , weight ]
      }
    }) // end of Swal
  }); // end of event
};

export { updatePatientInfo };
