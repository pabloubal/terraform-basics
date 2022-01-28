const { Client } = require('pg')
const express = require('express');
const app = new express();

const port = process.env.PORT || 4000;
const client = new Client({ 
  connectionString: process.env.DATABASE_URL,
  ssl: {rejectUnauthorized: false},
});

const execute = async() => {
    await client.connect()
    const res = await client.query('SELECT name FROM users')
    const users = res.rows.map(r => r.name).join(',');

    app.get('/', (req, res) => {
        res.send("<h1>Hello "+users+"</h1>")
    });

    app.listen(port, () => {
        console.log('App listening')
    });
}

execute();

