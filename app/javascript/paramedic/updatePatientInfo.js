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
      allowOutsideClick: false,
      confirmButtonText: 'UPDATE',
      preConfirm: () => {
        const age = parseInt(document.getElementById('input-age').value);
        const weight = parseInt(document.getElementById('input-weight').value);
        return [ age , weight ]
      }
    })

      Rails.fire(form, 'submit')

  }); // end of event
};

export { updatePatientInfo };
