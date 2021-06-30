import express from 'express';
import Joi from 'joi';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';

const app = express();
app.use(express.json());
app.use(cors());

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

app.get("/products/:productId", async (req, res) => {
    const {productId} = req.params;
    if(!parseInt(productId)){
        res.sendStatus(404);
        return;
    }
    try{
        const product = await connection.query(`
            SELECT *
            FROM products
            WHERE id = $1
        `,[parseInt(productId) ]);

        if(!product.rows[0]){
            res.sendStatus(404);
            return;
        }
        product.rows[0].price = (product.rows[0].price/100).toFixed(2).replace(".", ",");
        res.send(product.rows[0]);
    }
    catch(e){
        console.log(e);
        res.sendStatus(400);
    }
});

export default app;