import Sortable from 'sortablejs';

const activateDrugs = () => {
  const drugs = document.querySelector('#myUL');
  const active = document.querySelector('.active-container');
  // const active_drug = document.querySelectory

  Sortable.create(drugs, {
      group: {
          name: 'shared',
          pull: 'clone',
          put: false // Do not allow items to be put into this list
      },
      animation: 150,
      sort: false // To disable sorting: set sort to false
  });

  Sortable.create(active, {
      group: 'shared',
      animation: 150,
      onAdd: function(event){
        const drug_name = event.item.textContent;

      }
  });

// preventOnFilter
// remove clone on hide
// onAdd: function


};

export { activateDrugs };
