import express from 'express';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';
import sendGridMail from '@sendgrid/mail'
sendGridMail.setApiKey(process.env.SENDGRID_API_KEY);

import{ SignUpSchema, LoginSchema, AccountSchema, PasswordSchema} from "../Schemas/UserSchema.js";

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

    //Rota para Editar conta


    app.put("/Account", async(req,res)=>{
        const { name,email } = req.body;
        const authorization = req.headers['authorization'];
        const token = authorization?.replace('Bearer ', '');   
        if(!token) return res.sendStatus(400);
    
    const errors = AccountSchema.validate(req.body).error;
    
     if(errors) {
    console.log(errors)
    return res.sendStatus(400);
    }
        try{
            const result = await connection.query(`
            SELECT * FROM sessions
            JOIN users
            ON sessions."userId" = users.id
            WHERE sessions.token = $1
          `, [token]);
        
          const user = result.rows[0];

          if(user) {
            const UpdateAccount = await connection.query(`
            UPDATE users SET name=$1, email=$2 WHERE id=$3
          `, [name,email,user.userId]);
          return res.send({
            email: email,
            name:name,
            id:user.userId,
            token: user.token
          });
        
          } else {
            res.sendStatus(401);
          }
        }catch(e){
            console.log(e);
            return res.sendStatus(500);
        }
    
    
        });
    

    //Rota para mudar a senha

    app.put("/change_password", async(req,res)=>{
        const { email,password,confirmPassword } = req.body;
    
    const errors = PasswordSchema.validate(req.body).error;
    
     if(errors) {
    console.log(errors)
    return res.sendStatus(400);
    }
        try{
            const result = await connection.query(`
            SELECT * FROM users
            WHERE users.email = $1
          `, [email]);
        
          const user = result.rows[0];

          if(user) {
            const encryptedPassword = bcrypt.hashSync(password, 10);
            const newPassword = await connection.query(`
            UPDATE users SET password=$1 WHERE email=$2
          `, [encryptedPassword,user.email]);
          return res.sendStatus(200);
        
          } else {
            res.sendStatus(404);
          }
        }catch(e){
            console.log(e);
            return res.sendStatus(500);
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

app.get("/product/:productId", async (req, res) => {
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

app.get("/category/:categoryName", async (req, res) => {
    const { categoryName } = req.params;
    if(!categoryName){
        res.sendStatus(404);
        return;
    }
    try{
        const products = await connection.query(`
            SELECT products.*
            FROM products
            JOIN categories
            ON categories.id = products.categoryid
            WHERE categories.name = $1
        `,[categoryName]);

        if(products.rows.length < 1){
            res.sendStatus(404);
            return;
        }
        products.rows.map(n=>(n.price = (n.price/100).toFixed(2).replace(".", ",")));
        res.send(products.rows);
    }
    catch(e){
        console.log(e);
        res.sendStatus(400);
    }
});

app.post('/finish', async (req,res)=>{
    const {cart}  = req.body;

    if(!cart) return res.sendStatus(401);
    const authorization = req.headers['authorization'];
    const token = authorization?.replace('Bearer ', '');    
    if(!token) return res.sendStatus(400);
    try{
        const checkUserId = await connection.query(`
            SELECT * from sessions
            where token = $1
        `, [token])
        const userId = (checkUserId.rows[0].userId);

        if(userId){
            await connection.query(`
            INSERT INTO purchase
            ("userId", "productId")
            VALUES ($1, $2)
        `,[userId, cart]);
        res.sendStatus(201);
       
        const result= await connection.query(`
        SELECT * FROM users
        WHERE users.id = $1
      `, [userId]);
    
      const user = result.rows[0];

        function getMessage() {
            const body = ` Olá, ${user.name}! Tudo bem?
            Seu pedido foi criado com sucesso, e os produtos já estão em separação.
            A equipe CampMarket agradece a preferência!
            `
            ;
            return {
              to: `${user.email}`,
              from: 'campmarket.bootcamp@gmail.com',
              subject: 'Seu pedido foi criado!',
              text: body,
              html: `${body}`
            };
          }
          async function sendEmail() {
              try {
                await sendGridMail.send(getMessage());
                console.log('Test email sent successfully');
              } catch (error) {
                console.error('Error sending test email');
                console.error(error);
                if (error.response) {
                  console.error(error.response.body)
                }
              }
            }
          
            (async () => {
              console.log('Sending test email');
              await sendEmail();
            })();
        }
        else{
            return sendStatus(401)
        }

    }catch(e){
        console.log(e);
        res.sendStatus(500)
    }
});

export default app;
