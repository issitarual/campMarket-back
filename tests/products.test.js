import app from '../src/app.js';
import supertest from 'supertest';
import connection from '../src/database/database.js';
import { login } from './Util.js';

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

describe("POST /finish", ()=>{
    beforeEach(async () => {
        await connection.query(`DELETE FROM users`);
        await connection.query(`DELETE FROM sessions`);
    });
    it("returns 401 for empty params", async () => {
        const token = await login();
        const body = {};
        const result = await supertest(app).post("/finish").send(body).set('Authorization', `Bearer ${token}`);;
        const status = result.status;
        expect(status).toEqual(401);
    });

    it("returns 401 for invalid token", async () => {
        const body = {
            product: {
                id: 5,
                name: 'Banana Prata Orgânica 1,5kg',
                categoryid: 1,
                description: 'A banana é uma fruta tropical rica em carboidratos, vitaminas e minerais que proporcionam diversos benefícios para a saúde, como garantir energia, aumentar a sensação de saciedade e de bem estar.',
                image: 'https://mercadoorganico.com/6398-large_default/banana-prata-organica-pct-osm.jpg',
                price: '8,54',
                categoryName: 'vegetables'
            },
            qtd: 1
        }
        const response = await supertest(app).post("/finish").send(body).set('Authorization', `Bearer invalidToken`);
        expect(response.status).toEqual(401);  
    });

    it("returns 201 for sucess", async () => {
        const token = await login();
        const body = {
            "cart":[ { "product":{
                        "id": 10,
                        "name": "Maçã Fuji 1kg",
                        "categoryid": 1,
                        "description": "A Maça Fuji é firme, crocante e doce na medida certa. Na cozinha, ela é propícia para ir ao fogo porque cria a suculência ideal para sobremesas, geleias e outros pratos cozidos. São cerca de 50 à 80 calorias por unidade, e uma grande riqueza em vitaminas A, B6, B12 e C. O consumo regular de maçãs auxilia no controle da glicemia, na redução das taxas de colesterol e ajuda na prevenção de doenças cardiovasculares.",
                        "image": "https://cdnconfianca.loja.biz/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/1/1/114508-8.jpg.jpg",
                        "price": "7,49",
                         "categoryName": "vegetables"}, "qtd": 1 } ]
            }
        const result = await supertest(app).post("/finish").send(body).set('Authorization', `Bearer ${token}`);
        console.log(result);
        expect(result.status).toEqual(201);  
    });

});