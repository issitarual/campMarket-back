import express from 'express';
import Joi from 'joi';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';

const app = express();
app.use(express.json());
app.use(cors());

app.get("/teste", (req, res) => {
    try{
        console.log("hey");
        res.sendStatus(200);
    }
    catch(e){
        console.log(e);
        res.sendStatus(400);
    }
});

app.get("/products", async (req, res) => {
    try{
        const products = await connection.query(`
            SELECT products.*, categories.name AS "categoryName"
            FROM products
            JOIN categories
            ON products.categoryid = categories.id
        `);

        products.rows.map(n => n.price = (n.price/100).toFixed(2).replace(".", ","))
        res.send(products.rows);
    }
    catch(e){
        console.log(e);
        res.sendStatus(400);
    }
});

export default app;