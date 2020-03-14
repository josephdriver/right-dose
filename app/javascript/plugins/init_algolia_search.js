import algoliasearch from "algoliasearch";

const initAlgoliaSearch = () => {
  const inputField = document.querySelector("#search");
  const indexType = document.getElementById("search").placeholder;

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex(indexType);

    inputField.addEventListener("input", () => {
      index.search(inputField.value, { hitsPerPage: 10, page: 0 }).then((content) => {
        console.log(content);
        const col1 = document.getElementById('c-1');
        const col2 = document.getElementById('c-2');
        const col3 = document.getElementById('c-3');
        const col4 = document.getElementById('c-4');
        // for i in (i = 0; i < content.hits.length; i += 1) {
        //   const col = document.getElementById(`c-${i}`);
        //   col.insertAdjacentHTML('beforeend', "");
        // };
        if (indexType == 'Paramedic') {
          const col5 = document.getElementById('c-5');
          content.hits.forEach(element => {
            col1.insertAdjacentHTML('beforeend', `<p>${element.first_name}, ${element.last_name}</p>`);
            col2.insertAdjacentHTML('beforeend', `<p>${element.email}</p>`);
            col3.insertAdjacentHTML('beforeend', `<p>${element.paramedic_type_id}</p>`);
            col4.insertAdjacentHTML('beforeend', `<p>${element.employee_num}</p>`);
            col5.insertAdjacentHTML('beforeend', `<p>${element.updated_at}</p>`);
          });
        } else {
          content.hits.forEach(element => {
            col1.insertAdjacentHTML('beforeend', `<p>${element.name}</p>`);
            col2.insertAdjacentHTML('beforeend', `<p>${element.presentations}</p>`);
            col3.insertAdjacentHTML('beforeend', `<p>${element.created_at}</p>`);
            col4.insertAdjacentHTML('beforeend', `<p>${element.updated_at}</p>`);
          });
        };
      }).catch(console.error);
    });
  }
}

export { initAlgoliaSearch };

