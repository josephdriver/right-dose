import { format } from 'date-fns'

const setTime = () => {
  let date_cntr = document.querySelector('#current-date');
  let time_cntr = document.querySelector('#current-time');

  let date = format(new Date, 'dd MMM yyyy').toUpperCase();
  let time = format(new Date, 'HH:mm:ss');

  date_cntr.innerHTML = date;
  time_cntr.innerHTML = time;
};

const updateTime = () => {
  setInterval(setTime, 1000);
}

export { updateTime };
