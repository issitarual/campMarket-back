import app from '../src/app.js';
import supertest from 'supertest';
import connection from '../src/database/database.js';

afterAll(() => {
    connection.end();
  });

describe("GET /products", () => {
    //tudo certo
   it("returns 200 & object for valid params", async () => {
       const result = await supertest(app).get("/products");
       expect(result.status).toEqual(200);
       expect(typeof result.body).toEqual("object");
   });
}); 

describe("GET /search", () => {
    //tudo certo
   it("returns 200 & object for valid params", async () => {
       const result = await supertest(app).get(`/search?search=limão`);
       expect(result.status).toEqual(200);
       expect(typeof result.body).toEqual("object");
   });
}); 

describe("GET /products/:productId", () => {
    //params como texto
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/products/text");
        expect(result.status).toEqual(404);
    });

    //params não existe
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/products/100");
        expect(result.status).toEqual(404);
    });

    //params existe
    it("returns 200 for valid params", async () => {
        const result = await supertest(app).get("/products/1");
        expect(result.status).toEqual(200);
        expect(typeof result.body).toEqual("object");
    });
}); 