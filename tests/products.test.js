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

describe("GET /product/:productId", () => {
    //params como texto
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/product/text");
        expect(result.status).toEqual(404);
    });

    //params não existe
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/product/100");
        expect(result.status).toEqual(404);
    });

    //sem params
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/product/");
        expect(result.status).toEqual(404);
    });

    //params existe
    it("returns 200 for valid params", async () => {
        const result = await supertest(app).get("/product/1");
        expect(result.status).toEqual(200);
        expect(typeof result.body).toEqual("object");
    });
}); 

describe("GET /category/:categoryName", () => {

    //params não existe
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/category/teste");
        expect(result.status).toEqual(404);
    });

    //sem params
    it("returns 404 for invalid params", async () => {
        const result = await supertest(app).get("/category/");
        expect(result.status).toEqual(404);
    });

    //params existe
    it("returns 200 for valid params", async () => {
        const result = await supertest(app).get("/category/meat");
        expect(result.status).toEqual(200);
        expect(typeof result.body).toEqual("object");
    });
}); 