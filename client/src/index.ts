import * as React from "react";
import * as ReactDOM from "react-dom";

import Application from "./components/Application";

async function index() {
  const placeholder = document.createElement("div");

  document.body.append(placeholder);

  function render() {
    const renderFunction = 
      placeholder.childElementCount === 0 ? ReactDOM.render : ReactDOM.hydrate;

    renderFunction(React.createElement(Application), placeholder);
  }

  render();
}

document.addEventListener("DOMContentLoaded", index);
