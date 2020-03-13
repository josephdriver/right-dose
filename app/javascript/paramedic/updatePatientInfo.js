import Swal from 'sweetalert2';

const updatePatientInfo = () => {
  const btn = document.querySelector('#patient-info-container');
  const form = document.querySelector('#hahaha');
  const update = document.getElementById('input-submit-btn');

  btn.addEventListener('click', async (e) => {
    const {value: output} = await Swal.fire(
    {
      title: 'EDIT PATIENT INFO',
      html: form,
      focusConfirm: false,
      showConfirmButton: true,
      preConfirm: () => {
        const age = parseInt(document.getElementById('input-age').value);
        const weight = parseInt(document.getElementById('input-weight').value);

        return [ age , weight ]
      }
    });
    Rails.fire(form, 'submit')
  })
};

export { updatePatientInfo };
