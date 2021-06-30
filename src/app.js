import express from 'express';
import Joi from 'joi';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';

import{ SignUpSchema, LoginSchema} from "../Schemas/UserSchema.js";

const app = express();
app.use(express.json());
app.use(cors());

// Rota para sign up

app.post("/signUp", async(req,res)=>{
    const {name,email,password, confirmPasswor}=req.body;
    
    const errors = SignUpSchema.validate(req.body).error;
    
    if(errors) {
        console.log(errors)
        return res.sendStatus(400);
    }
    
    try{
        const validation = await connection.query('SELECT * FROM users WHERE email = $1',[email]);
        if(validation.rows.length!==0){
            return res.sendStatus(409);
        }
    
    const encryptedPassword = bcrypt.hashSync(password, 10);
    
    
    await connection.query(`
    INSERT INTO users
    (name, email, password)
    VALUES ($1, $2, $3)
    `,[name, email,encryptedPassword]);
    
    return res.sendStatus(201);
    }
    catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
    
    });

    // Rota para Login

    app.post("/Login", async(req,res)=>{
        const { email, password } = req.body;

        const errors = LoginSchema.validate(req.body).error;
    
    if(errors) {
        console.log(errors)
        return res.sendStatus(400);
    }
     
        try{
        const result = await connection.query(`
            SELECT * FROM users
            WHERE email = $1
        `,[email]);
    
        const user = result.rows[0];
       
        if(result.rows.length>0 && bcrypt.compareSync(password, user.password)) {
            
            const token = uuid();
    
            await connection.query(`
            INSERT INTO sessions ("userId", token)
            VALUES ($1, $2)
          `, [user.id, token]);
    
            return res.send({
                id:user.id,
                name:user.name,
                email:user.email,
                token:token
            });
        } else {
            return res.sendStatus(401);
        }
    }
    catch(e){
        console.log(e)
        res.sendStatus(500);
    }
        });


    // Rota para LogOut
    app.delete("/logOut", async (req,res) => {
            const authorization = req.headers['authorization'];
            const token = authorization?.replace('Bearer ', '');    
            if(!token) return res.sendStatus(400);
            
            try{
            const result = await connection.query(`
            SELECT * FROM sessions
            JOIN users
            ON sessions."userId" = users.id
            WHERE sessions.token = $1
          `, [token]);
        
          const user = result.rows[0];
          
          if(user) {
            const deleteToken = await connection.query(`
            DELETE FROM sessions WHERE sessions.token = $1
          `, [token]);
          return res.sendStatus(200);
        
          } else {
            res.sendStatus(401);
          }
        }catch(e){
            console.log(e);
            return res.sendStatus(500);
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

app.get(`/search`, async (req,res)=>{
    const { search } = req.query
    try{
        const result = await connection.query(`
            SELECT * FROM products
            where
            name ILIKE $1
        `, ["%"+search+"%"])
        res.send(result.rows);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }
});



export default app;