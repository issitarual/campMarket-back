import express from 'express';
import Joi from 'joi';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';

import{SignUpSchema} from "../Schemas/UserSchema.js";

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
     return res.sendStatus(200);
        
        });

        app.delete("/LogOut", async(req,res)=>{
            return res.sendStatus(200);
               
               });
export default app;