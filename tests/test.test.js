import app from '../src/app.js';
import supertest from 'supertest';
import connection from '../src/database/database.js';

afterAll(() => {
    connection.end();
  });

describe("GET /products", () => {
    //tudo certo
   it("returns text for valid params", async () => {
       const result = await supertest(app).get("/products");
       expect(result.status).toEqual(200);
       expect(typeof result.body).toEqual("object");
   });
}); 