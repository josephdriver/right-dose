const noRefresh = () => {
  const queue = document.querySelectorAll('#myUL > li');

  queue.forEach((e) => {
    e.addEventListener("click", (event) => {
      event.preventDefault();
    })
  });
}

export { noRefresh };
