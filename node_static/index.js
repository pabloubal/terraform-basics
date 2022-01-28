const express = require('express');
const app = new express();

const port = process.env.PORT || 4000;

const execute = async() => {
    app.get('/', (req, res) => {
        res.send("<h1>Hello World!</h1>")
    });

    app.listen(port, () => {
        console.log('App listening')
    });
}

execute();

