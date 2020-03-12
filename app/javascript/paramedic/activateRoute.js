const activateRoute = () => {
  const list = document.querySelector('.ad-route-list');
  const items = document.querySelectorAll('.btn-route');

  // CLICK FUNCTIONALITY
  items.forEach((element) => {
    element.addEventListener('click', (event) => {
      event.preventDefault();

      // remove active from siblings
      items.forEach((e) => {
        if ( e !== event.currentTarget) e.classList.remove('btn-route-active');
      });

      // add active to current target
      event.currentTarget.classList.toggle('btn-route-active');
    });
  });
}

export { activateRoute };
