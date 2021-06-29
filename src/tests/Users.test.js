
import app from '../app.js';
import supertest from 'supertest';
import connection from '../database/database.js'

import { login } from './Util.js';

afterAll(async() => {
    connection.end();
});

describe("POST /signUp", () => {

    beforeEach(async () => {
        await connection.query(`DELETE FROM users`);
      });
    
    it("returns 201 for valid params", async () => {
        const body = {
            name: 'fulano',
            email: 'fulano@gmail.com',
            password: '1',
            confirmPassword:'1'
          };
        
          const result = await supertest(app).post("/signUp").send(body);
          const status = result.status;
          
          expect(status).toEqual(201);
    });

    it("returns 400 for empty params", async () => {
        const body = {};
        
          const result = await supertest(app).post("/signUp").send(body);
          const status = result.status;
          
          expect(status).toEqual(400);
    });

    it("returns 400 for invalid params", async () => {
        const body = {           
        name: 'fulano',
        email: 'fulano@gmail.com',
        password: '1',
        confirmPassword:'2'};
        
          const result = await supertest(app).post("/signUp").send(body);
          const status = result.status;
          
          expect(status).toEqual(400);
    });


    it("returns 400 for Email address already registered", async () => {
        const body = {
            name: 'fulano',
            email: 'fulano@gmail.com',
            password: '1',
            confirmPassword:'1'
          };
        
          const result = await supertest(app).post("/signUp").send(body);
        const Newbody = {
            name: 'fulano2',
            email: 'fulano@gmail.com',
            password: '2',
            confirmPassword:'2'
        };
        
          const response = await supertest(app).post("/signUp").send(body);
          const status = response.status;
          
          expect(status).toEqual(409);
    });    

});

describe("POST /Login", () => {
    beforeEach(async () => {
        await connection.query(`DELETE FROM users`);
      });

    it("returns object containing user information and token for valid params", async () => {
        const signUp = {
            name: 'fulano',
            email: 'fulano@gmail.com',
            password: '1',
            confirmPassword:'1'
          };
        
          const signUpResult = await supertest(app).post("/signUp").send(signUp);

        const body = {
            email: 'fulano@gmail.com',
            password: '1'
          };        
          const result = await supertest(app).post("/Login").send(body);
        


          
          expect(JSON.parse(result.text)).toEqual(
            expect.objectContaining({
                "email": "fulano@gmail.com", "id": expect.any(Number), "name": "fulano", "token" : expect.any(String)
            })

    );
});

it("returns 400 for invalid params", async () => {
    const signUp = {
        name: 'fulano',
        email: 'fulano@gmail.com',
        password: '1',
        confirmPassword:'1'
      };
    
      const signUpResult = await supertest(app).post("/signUp").send(signUp);

    const body = {
        email: 'fulano@gmail.com',
        password: '4'
      };        
      const result = await supertest(app).post("/Login").send(body);
      const status = result.status;
      expect(status).toEqual(401);
});

it("returns 400 for empty params", async () => {
    const body = {};
    
      const result = await supertest(app).post("/Login").send(body);
      const status = result.status;
      
      expect(status).toEqual(400);
});
});


describe("POST /LogOut", () => {
    beforeEach(async () => {
        await connection.query(`DELETE FROM users`);
        await connection.query(`DELETE FROM sessions`);
      });

    it("returns object containing user information and token for valid params", async () => {
        const token = await login();
          const response = await supertest(app).delete("/logOut").set('Authorization', `Bearer ${token}`);
          expect(response.status).toEqual(200);  

    
});




});