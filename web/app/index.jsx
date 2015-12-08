import './css/main.css';

import React from 'react';
import ReactDOM from 'react-dom';
import 'array.prototype.findindex';
import App from './components/App.jsx';

main();

function main() {
    const app = document.createElement('div');

    document.body.appendChild(app);

    ReactDOM.render(<App />, app);
}