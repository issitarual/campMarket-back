--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text,
    categoryid integer,
    description text,
    image text,
    price integer
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: purchase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    "userId" integer,
    "productId" text[]
);


--
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer,
    token text
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text,
    email text,
    password text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories VALUES (1, 'vegetables');
INSERT INTO public.categories VALUES (2, 'meat');
INSERT INTO public.categories VALUES (3, 'cold products');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.products VALUES (1, 'Batata Inglesa 1,5kg', 1, 'Fonte de carboidratos, magnésio e potássio, além de um pouco de vitaminas B e C', 'https://arcomixstr.blob.core.windows.net/product/5990-batata-inglesa-vinagrete-kg-g.jpg', 297);
INSERT INTO public.products VALUES (2, 'Couve Flor Unidade', 1, 'A couveflor é uma hortaliça rica em cálcio e fósforo e fonte de ácido fólico e vitamina C . Como Conservar:Na geladeira pode ser conservada por 3 a 5 dias, dentro de saco plástico perfurado. Antes de guardar, remova as partes escuras e folhas, mas não lave a cabeça.Como Consumir:Pode ser consumida assada, frita ou cozinhe em água e sal.', 'https://cdn.shopify.com/s/files/1/0946/5368/products/cauliflower-vegetable_2048x.jpg?v=1440445114', 549);
INSERT INTO public.products VALUES (3, 'Brócolis Americano Unidade', 1, 'O brócolis é uma hortaliça com poucas calorias. É fonte de fósforo, ferro, cálcio, fibras e também possui vitamina C .Como conservar: Em geladeira doméstica, pode ser mantido por até 4 dias dentro de saco plástico perfurado.Como consumir :Pode ser consumido cru em saladas ou cozido em saladas, sopas suflês, bolos e refogados . O cozimento deve ser feito em vapor ou em panela tampada com pouca água.', 'https://www.loja.belissimacasadifrutas.com.br/imagem/index/24559730/G/2014128_broq.jpg', 499);
INSERT INTO public.products VALUES (4, 'Pimentão Verde 600g', 1, 'Fonte de vitaminas A e C e betacaroteno. Pimentão verde possui acidez mais pronunciada, tem melhor digestão sem pele e sementes. Para retirar a pele queime no fogo. Bom em moquecas e refogados', 'https://www.proativaalimentos.com.br/image/cache/catalog/img_prod/1065[1]-1000x1000.jpg', 281);
INSERT INTO public.products VALUES (5, 'Banana Prata Orgânica 1,5kg', 1, 'A banana é uma fruta tropical rica em carboidratos, vitaminas e minerais que proporcionam diversos benefícios para a saúde, como garantir energia, aumentar a sensação de saciedade e de bem estar.', 'https://mercadoorganico.com/6398-large_default/banana-prata-organica-pct-osm.jpg', 854);
INSERT INTO public.products VALUES (6, 'Limão Tahiti 700g', 1, 'Limões são ácidos, azedos e não muito agradáveis ao paladar, mas não se engane, pois eles são alcalinizantes no corpo. Isso os tornam ótimos para equilibrar uma condição altamente ácida corpórea, além de possuir inúmeros benefícios. São ricos em Vitamina C e Flavonoides que trabalham contra infecções como a gripe e resfriados.', 'https://hiperideal.vteximg.com.br/arquivos/ids/167645-1000-1000/15890.jpg?v=636615816092500000', 293);
INSERT INTO public.products VALUES (7, 'Cenoura 1kg', 1, 'A bandeja de aproximadamente 1kg contém de 4 a 5 unidades, de acordo com a safra.*Para adquirir 2 ou mais bandejas basta aumentar a quantidade.', 'https://cdn.shopify.com/s/files/1/0130/2767/2128/products/cenoura.jpg?v=1555112143', 399);
INSERT INTO public.products VALUES (8, 'Tomate Carmen 1kg', 1, 'Conhecido também como tomate Longa Vida, é o mais consumido no País. Tem alta durabilidade graças aos genes da composição, mas esses mesmos genes também influenciam no sabor e no aspecto. É um tomate mais aguado e amarelado, ideal para salada, mas ruim para molhos, que tendem a ficar mais alaranjados e sem sabor.', 'https://zonasul.vtexassets.com/arquivos/ids/161656/8853VF4qT-qqCUAA.png?v=637367659914470000', 499);
INSERT INTO public.products VALUES (9, 'Laranja Pera 1,2kg', 1, 'De sabor doce e agradável, também é conhecida como laranja pera rio. De forma mais alongada apresenta a casca lisa e fina com polpa bastante suculenta. A laranja pera contém uma variedade de fitoquímicos como hesperedina e naringenina. Essa última tem um efeito bioativo na saúde humana como antioxidante, eliminador de radicais livres, antiinflamatório e modulador do sistema imunológico. São Ricas em Vitaminas A e C.', 'https://i0.wp.com/mercadogaia.com.br/wp-content/uploads/2020/10/laranja-pera.jpg?fit=1456%2C1452&ssl=1', 527);
INSERT INTO public.products VALUES (11, 'Carne Moída Tradicional Do Seu Jeito 600g', 2, 'A carne está repleta de vitamina B12, zinco e ferro - que são importantes para o crescimento muscular e desenvolvimento.', 'https://images.zonasul.com.br/imagem1000X1000/20201214_1233-(1).jpg', 2999);
INSERT INTO public.products VALUES (12, 'Manteiga Com Sal Itambé Tablete 200g', 3, 'Quando a manteiga é boa, ela é gostosa, consistente e tão cremosa que hummm. Fica impossível resistir! Porção de 10g (1 colher de sopa) = 72 kcal.', 'https://zonasul.vtexassets.com/arquivos/ids/165431/22358VF4qT-qqCUAA.png?v=637370371917170000', 1190);
INSERT INTO public.products VALUES (16, 'Salmão Em Filé Fresco Resfriado 1kg', 2, 'Por seu sabor único e grande versatilidade, o salmão é um peixe amplamente consumido e muito famoso na culinária mundial. Altamente nutritivo, é rico em ômega-3, ácidos graxos, vitamina D e selênio. Pode ser consumido cru, defumado, grelhado, assado ou frito. Com pele e sem espinhas.', 'https://zonasul.vtexassets.com/arquivos/ids/373502/22967VF4qT-qqCUAA.png?v=637423960037530000', 13990);
INSERT INTO public.products VALUES (10, 'Maçã Fuji 1kg', 1, 'A Maça Fuji é firme, crocante e doce na medida certa. Na cozinha, ela é propícia para ir ao fogo porque cria a suculência ideal para sobremesas, geleias e outros pratos cozidos. São cerca de 50 à 80 calorias por unidade, e uma grande riqueza em vitaminas A, B6, B12 e C. O consumo regular de maçãs auxilia no controle da glicemia, na redução das taxas de colesterol e ajuda na prevenção de doenças cardiovasculares.', 'https://statics.angeloni.com.br/super/files/produtos/158070/158070_1_zoom.jpg', 749);
INSERT INTO public.products VALUES (13, 'Picanha Bassi 1,5kg', 2, 'Ela é a estrela dos churrascos brasileiros, e não à toa. Graças à capa de gordura e ótimo marmoreio, a picanha é macia, suculenta e saborosa. A picanha é retirada no local correto do corte, na famosa terceira veia, evitando que tenha parte de coxão duro na peça.', 'https://zonasul.vtexassets.com/arquivos/ids/2961619/32596VF4qT-qqCUAA.png?v=637550565098100000', 17998);
INSERT INTO public.products VALUES (14, 'Filet Mignon Peça Desengordurado 1,4kg', 2, 'O filé mignon é um tipo de corte de carne bovina. É a parte mais tenra da ponta do filé. É localizada na parte traseira do animal e representa, aproximadamente, 2,95% da carcaça. É o corte mais macio da carne bovina e quase não contém gordura.', 'https://images.zonasul.com.br/imagem1000X1000/201861_1223(1).jpg', 12599);
INSERT INTO public.products VALUES (15, 'Tilápia Fresca Em Filés Resfriada 1kg', 2, 'A Tilápia possui carne branca e magra, sabor leve e textura suave. Por ser um peixe bastante versátil ele é muito apreciado no Brasil. Fonte de selênio, que atua no rejuvenescimento das células, a Tilápia ajuda a prevenir doenças como o câncer, mal de Alzheimer e artrite.', 'https://zonasul.vtexassets.com/arquivos/ids/1965854/29738VF4qT-qqCUAA.png?v=637459962080600000', 5890);
INSERT INTO public.products VALUES (17, 'Lagarto Redondo Desengordurado Peça Corte D Oro 1,3kg', 2, 'Localizado na parte traseira do boi, o lagarto tem fama de ser uma das carnes mais secas e magras do animal. As suas fibras são de tom vermelho-claro devido à pouca irrigação e ausência de marmoreio, por não ter gordura entremeada. A carne exige um preparo com longo tempo de cozimento para ficar tenra e macia.', 'https://images.zonasul.com.br/imagem1000X1000/201861_1229.jpg', 7409);
INSERT INTO public.products VALUES (18, 'Rabanete Unidade
', 1, 'O rabanete é fonte de Vitamina C, fósforo,fibras e possui poucas calorias. Como Conservar: Conservar em geladeira, dentro de sacos de plástico. Antes de armazenálos remova as folhas. Caso seja preciso lavar os rabanetes antes de armazenálos na geladeira, sequeos com pano limpo. Como Consumir: O rabanete é consumido na forma crua, em saladas, cozido ou em forma de petiscos.', 'https://images.zonasul.com.br/imagem1000X1000/2014130_Rabanete.jpg', 499);
INSERT INTO public.products VALUES (19, 'Jiló 600g', 1, 'A bandeja aproximadamente 600 g contém de 8 a 10 unidades,de acordo com a safra.', 'https://images.zonasul.com.br/imagem1000X1000/2020518_1903.jpg', 329);
INSERT INTO public.products VALUES (20, 'Repolho Roxo 1kg', 1, 'O repolho é uma hortaliça rica em sais minerais sobre tudo cálcio e fósforo, e possui vitaminas C, B1,B2, E e K. Como conservar: Sob refrigeração pode ser mantido por várias semanas, desde que colocado dentro de sacos de plásticos. Quando picado, deve ser mantido embalado ou em vasilha tampada na geladeira. Como Consumir: O repolho pode ser consumido cru em saladas, cozido em água ou leite fermentado( chucrute.) Deve ser cozido somente pelo tempo suficiente para tornar as folhas macias.', 'https://images.zonasul.com.br/imagem1000X1000/2020518_3742.jpg', 699);
INSERT INTO public.products VALUES (21, 'Alface Lisa Unidade', 1, 'A alface é uma hortaliça essencial para as saladas devido ao seu sabor agradável e refrescante. Além de ter um fácil preparo é uma importante fonte de sais minerais, cálcio e vitaminas, principalmente a vitamina A. Como conservar: Sem refrigeração – Deve ser conservada com a parte de baixo dentro de uma vasilha com água ou dentro de saco plástico aberto, por até 1 dia. Com refrigeração (geladeira) – Manter em uma vasilha de plástico tampada ou em saco plástico, retirandose as folhas de acordo com a necessidade de consumo, por até 3 a 4 dias. Como consumir: Lavar as folhas em água corrente, depois deixalas de molho em solução de hipoclorito de sódio, por até 30 min. e em seguida enxaguálas com água filtrada. ', 'https://images.zonasul.com.br/imagem1000X1000/2014128_Alface%20Lisa1.jpg', 229);
INSERT INTO public.products VALUES (22, 'Tangerina Ponkan 1,2kg', 1, 'No Brasil, a variedade mais famosa é a ponkan, que tem gosto mais doce em comparação com as outras tangerinas. Árvore de porte médio a grande, copa ereta, atinge alta produtividade. Seus frutos são de casca solta com baixa teor de acidez e de tamanho médios a grandes. Maturação precoce. Com finalidade para mesa e suco. A tangerina é rica em vitaminas B1 e B2, as quais ajudam à saúde dos nervos, pele, olhos, cabelos, fígado e boca.  Além de conter grande quantidade de fibras, de sais minerais como magnésio, potássio, cálcio e fósforo, e da substância betacaroteno (precursor da vitamina A), que aumenta a resistência às infecções.', 'https://images.zonasul.com.br/imagem1000X1000/2020512_tangerina_1088-0.jpg', 563);
INSERT INTO public.products VALUES (23, 'Abacate 1kg', 1, 'Peso Aproximado 1Kg. O Abacate é uma das frutas mais completas para a saúde. Rico em Ômega 3, Vitamina C, Ácido Fólico, Magnésio, Antioxidantes e Fibras. É ótimo para pele, pois estimula a produção de colágeno. É uma Importante fonte de energia pós treino. Auxilia na capacidade da memória e circulação sanguínea. Experimente em vitaminas, cremes, saladas, guacamole e até em brigadeiros.', 'https://images.zonasul.com.br/imagem1000X1000/2020424_1139-8-_Abacate-700-g.jpg', 749);
INSERT INTO public.products VALUES (24, 'Sobrecoxa De Frango Congelada Bandeja 600g', 2, 'Os Frangos Livres de Transgênicos da Korin fazem parte da Linha Sustentável, e são provenientes de aves criadas com alimentação vegetariana à base de grãos NÃO transgênicos, certificada pelo IBD Certificações.O Frango Livre de Transgênicos Korin, ajuda a contribuir com a biodiversidade, preservando o patrimônio genético de plantas e sementes e colaborando para a preservação do nosso planeta. ', 'https://images.zonasul.com.br/imagem1000X1000/202019_47342.jpg', 1499);
INSERT INTO public.products VALUES (25, 'Sobrecoxa De Frango Congelada 1kg', 2, 'Cortes congelados de Frango Sobrecoxa. Sistema abrefecha fácil. Congelados soltinhos. Permite retirar uma peça por vez.', 'https://zonasul.vtexassets.com/arquivos/ids/164279/27558VF4qT-qqCUAA.png?v=637369670510200000', 1399);
INSERT INTO public.products VALUES (26, 'Peito de Frango em Filés Bandeja 1 kg', 2, 'Com baixo teor de gordura e rico em nutrientes essenciais para o organismo, o Filé de Peito de Frango é uma excelente alternativa para compor dietas saudáveis e equilibradas e em diversos preparos, bastando descongelar, temperar e preparar como preferir.', 'https://images.zonasul.com.br/imagem1000X1000/2020515_57439.jpg', 1799);
INSERT INTO public.products VALUES (27, 'Espetinho de Coração de Frango 1kg', 2, 'Uma ótima opção para o churrasco, o Espetinho de Coração Sadia tem um tempero especial de alho, molho de soja, cebola, um toque de pimenta preta, gengibre e orégano, que torna qualquer churrasco mais saboroso. Pronto para assar na grelha, é prático, gostoso e garantia de sucesso.', 'https://images.zonasul.com.br/imagem1000X1000/2020511_36889.jpg', 3999);
INSERT INTO public.products VALUES (28, 'Bacon Pedaço Sadia 500g', 2, 'Toucinho de porco defumado. Indicado para dar sabor à prepraros com vegetais, carnes e molhos.', 'https://images.zonasul.com.br/imagem1000X1000/201866_1290.jpg', 1950);
INSERT INTO public.products VALUES (29, 'Filet Mignon Suíno Temperado 1kg', 2, 'O Filé Mignon é uma carne tenra, magra e suculenta. É um corte nobre do suíno, muito versátil e diferenciado que pode acompanhar diversos pratos e ocasiões. Agora com ainda mais praticidade no preparo pois já vem pronto para assar no saco assa fácil, não precisa descongelar.', 'https://images.zonasul.com.br/imagem1000X1000/20191126_9326.jpg', 2899);
INSERT INTO public.products VALUES (30, 'Carré Suíno Fatiado Congelado 1,5kg', 2, 'Corte que inclui o lombo do porco com os ossos da costela dorsal. Indicado para ser grelhado em porções mais altas, para que fique suculento.', 'https://images.zonasul.com.br/imagem1000X1000/2011715_3410.jpg', 3299);
INSERT INTO public.products VALUES (31, 'Linguiça Tipo Calabresa Defumada 500g', 2, 'Defumadinha no ponto certo, é um produto versátil, ideal para deixar o seu feijão ainda mais saboroso e dar aquele toque especial em variadas receitas.', 'https://images.zonasul.com.br/imagem1000X1000/2020511_40757.jpg', 1899);
INSERT INTO public.products VALUES (32, 'Salsicha Hot Dog Sadia 500g', 2, 'Além de ser saborosa e macia, a Salsicha - Hot Dog é a mais vendida do Brasil* por não ter corantes artificiais e combinar com qualquer receita.', 'https://images.zonasul.com.br/imagem1000X1000/2020511_14444.jpg', 1290);
INSERT INTO public.products VALUES (33, 'Salmão Marinado Congelado Defumado 100g', 2, 'Pronto para consumo!
Dica: Se preferir, é só aquecer no microondas. Ideal para aperitivo.', 'https://images.zonasul.com.br/imagem1000X1000/2019115_49613.jpg
', 2690);
INSERT INTO public.products VALUES (34, 'Iogurte Danone Morango 900g', 3, 'Com 100 anos de experiência, criamos com amor e cuidado: leite, creme de leite, requeijão e uma linha completa de iogurtes. O iogurte líquido 900g no sabor morango é pronto para consumo e feito com frutas naturais. É fonte de cálcio, saboroso, prático para a sua família e o melhor, agora com Vitaminas C e D em sua formulação.', 'https://images.zonasul.com.br/imagem1000X1000/2020124_90391a.jpg', 1229);
INSERT INTO public.products VALUES (35, 'Mortadela Defumada Em Fatias Bandeja 200g', 3, 'A Mortadela Defumada Sadia é Muito Suculenta, Irresistível. e Ideal Para Comer Como Você Quiser, Seja Em Lanches Ou Receitas.', 'https://zonasul.vtexassets.com/arquivos/ids/1960322/29789VF4qT-qqCUAA.png?v=637459917520800000', 518);
INSERT INTO public.products VALUES (36, 'Presunto Cozido Fatiado 200g', 3, 'Produzido a partir de pernil suíno, o Presunto é rico em proteínas e possui baixo teor de gordura.', 'https://images.zonasul.com.br/imagem1000X1000/2014522_12.jpg', 598);
INSERT INTO public.products VALUES (37, 'Salame Tipo Italiano Fatiado 200g', 3, 'Feito com carnes selecionadas de pernil, paleta e pancetta resfriadas de suínos adultos, embutidas em tripa natural ou artificial, o Salame Italiano é levemente defumado e depois conduzido para maturação por mínimo 45 a 60 dias em salas especiais com umidade, temperatura e ventilação controladas.', 'https://images.zonasul.com.br/imagem1000X1000/201795_SALAME-hamb.jpg', 2198);
INSERT INTO public.products VALUES (38, 'Chandelle Chocolate Com 2 Unidades 180g', 3, 'Deliciosa sobremesa láctea cremosa com o exclusivo sabor do puro chocolate NESTLÉ®. É uma ótima opção de sobremesa, prática e deliciosa. NÃO CONTÉM GLÚTEN.', 'https://images.zonasul.com.br/imagem1000X1000/2016219_109665.jpg', 689);
INSERT INTO public.products VALUES (39, 'Flan Nestlé Baunilha com Calda de Caramelo', 3, 'Delicioso Flan sabor baunilha com uma irresistível calda de caramelo.ALÉRGICOS: CONTÉM LEITE E DERIVADOS. CONTÉM LACTOSE. NÃO CONTÉM GLÚTEN.', 'https://images.zonasul.com.br/imagem1000X1000/2020218_91179.jpg', 589);
INSERT INTO public.products VALUES (40, 'Sobremesa Pudim de Leite 200g', 3, 'Chegou Batavo Delícias do Forno, Pudim de Leite Condensado! Pudim como feito em casa, com apenas 4 ingredientes e sem conservantes. O único com a receita da Holandesa.', 'https://zonasul.vtexassets.com/arquivos/ids/2956306/31655VF4qT-qqCUAA.png?v=637493466155600000', 789);
INSERT INTO public.products VALUES (41, 'Sobremesa Láctea Zero Adição De Açúcar Damasco', 3, 'A sobremesa aerada sabor Damasco é leve, gostosa e zero adição de açúcares.', 'https://images.zonasul.com.br/imagem1000X1000/201974_38344.jpg', 549);
INSERT INTO public.products VALUES (42, 'Queijo Tipo Grana Padano Triângulo 300g', 3, 'Queijo Tipo Grana em lascas Gran Formaggio, elaborado com selecionados ingredientes, no mínimo 12 meses de maturação, o que confere seu sabor intenso e agradável com aroma único. Muito apreciado em risotos, sopas e massas e gratinados.', 'https://images.zonasul.com.br/imagem1000X1000/201952_queijo.jpg', 5397);
INSERT INTO public.products VALUES (43, 'Queijo Parmesão Cilindro 195g', 3, 'De origem Italiana, é feito de leite de vaca coletado após a ordenha e é parcialmente desnatado pela gravidade. Apresenta sabor picante e sua textura é levemente cristalizada, sua casca é dura e grossa. Sua cor é amarelo-forte.', 'https://images.zonasul.com.br/imagem1000X1000/2018726_89785.jpg', 3790);
INSERT INTO public.products VALUES (44, 'Margarina Com Sal Pote 500g', 3, 'De origem vegetal, feita da hidrogenação de óleos vegetais como de milho ou girassol. Nesse processo, uma parte das gorduras insaturadas (mais saudáveis do que as saturadas) da receita se transforma em gordura trans. Este tipo de gordura é pouco comum na natureza, mas costuma ser feito pela indústria para dar cremosidade aos produtos e aumentar a duração.', 'https://images.zonasul.com.br/imagem1000X1000/202056_11599.jpg
', 679);
INSERT INTO public.products VALUES (45, 'Queijo Minas Padrão Fracionado 500g', 3, 'Um dos mais tradicionais em Minas Gerais, o Queijo Meia Cura tem sabor suave e textura firme, e é o principal ingrediente do verdadeiro pão de queijo mineiro.', 'https://images.zonasul.com.br/imagem1000X1000/2018910_8330.jpg
', 2097);
INSERT INTO public.products VALUES (46, 'Manteiga com Sal 200 g', 3, 'Manteiga com sal de primeira qualidade.', 'https://images.zonasul.com.br/imagem1000X1000/2020116_82029.jpg
', 1249);
INSERT INTO public.products VALUES (47, 'Muçarela em Fatias Bandeja 250 g', 3, 'De origem Italiana a Mussarela é um queijo de massa filada, famosa pelo seu poder de fatiamento e derretimento. Sua grande procura fez com que a Mussarela se disseminasse pelo mundo, sendo hoje o queijo de maior presença na mesa dos consumidores brasileiros.', 'https://images.zonasul.com.br/imagem1000X1000/3895.jpg', 2495);


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (2, 1, '58f6b18f-d379-4693-a607-b222a2710292');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'example', 'example@email.com', '$2b$10$0OInEtrg5Bb4tYjPIq.4H.BYFH..V9peTsOS1/z0acHEjOZDIAYPO');


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 3, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 47, true);


--
-- Name: purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.purchase_id_seq', 1, false);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

