import Sortable from 'sortablejs';

const initSortable = () => {
  const drugs = document.querySelector('.drug');
  Sortable.create(drugs);
};

export { initSortable };
