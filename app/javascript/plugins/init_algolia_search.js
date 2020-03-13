import algoliasearch from "algoliasearch";

const initAlgoliaSearch = () => {
  // const inputField = document.querySelector("#search");

  // if (inputField) {
  //   const appId = document.querySelector("meta[name='algolia-app-id']").content;
  //   const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

  //   const client = algoliasearch(appId, searchOnlyApiKey);
  //   const index = client.initIndex('Drug');
  //   console.log(index);

  //   inputField.addEventListener("input", () => {
  //     index.search(inputField.value, { hitsPerPage: 10, page: 0 }).then((content) => {
  //       console.log(content);
  //       // to filter results, need to insertAdjacentHTML with js
  //       // handle results however you like...
  //     }).catch(console.error);
  //   });
  // }
}

export { initAlgoliaSearch };
