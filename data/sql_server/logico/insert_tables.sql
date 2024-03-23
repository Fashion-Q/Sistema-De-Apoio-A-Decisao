use hawkmart;
insert into cliente (nome,cpf,email,cep,cidade,estado) values
('Nadianne','11111111111','naninha@gmail.com','99999999','Recife','PE'),
('Verenyce','22222222222','verenyce@gmail.com','88888888','Areia Branca','SE'),
('Valdir Valdir Valdir','33333333333','valdirvaldir@gmail.com','77777777','Itabaiana','SE'),
('Rogério Silva', '44444444444', 'rogerio.silva@gmail.com', '66666666', 'Aracaju', 'SE'),
('Aline Oliveira', '55555555555', 'aline.oliveira@gmail.com', '55555555', 'Maceió', 'AL'),
('Fernando Santos', '66666666666', 'fernando.santos@gmail.com', '44444444', 'João Pessoa', 'PB'),
('Camila Souza', '77777777777', 'camila.souza@gmail.com', '33333333', 'Natal', 'RN'),
('Marcelo Lima', '88888888888', 'marcelo.lima@gmail.com', '22222222', 'Fortaleza', 'CE'),
('Carolina Costa', '99999999999', 'carolina.costa@gmail.com', '11111111', 'Teresina', 'PI'),
('Ricardo Pereira', '10101010101', 'ricardo.pereira@gmail.com', '12345678', 'Salvador', 'BA'),
('Patrícia Oliveira', '12121212121', 'patricia.oliveira@gmail.com', '23456789', 'Aracaju', 'SE'),
('Lucas Rocha', '13131313131', 'lucas.rocha@gmail.com', '34567890', 'Maceió', 'AL'),
('Juliana Santos', '14141414141', 'juliana.santos@gmail.com', '45678901', 'João Pessoa', 'PB'),
('André Costa', '15151515151', 'andre.costa@gmail.com', '56789012', 'Natal', 'RN'),
('Ana Lima', '16161616161', 'ana.lima@gmail.com', '67890123', 'Fortaleza', 'CE');

insert into categoria (nome,codigo) values
('Eletrônicos',1),
('Roupas',2),
('Livros',3),
('Jogos',4);

insert into subcategoria (nome,codigo,id_categoria) values
('Smartphones',1,1),
('Laptops',2,1),
('TV',3,1),
('Consoles',4,1),
('Calças',5,2),
('Vestidos',6,2),
('Blusa',7,2),
('Permuda',8,2),
('Short',9,2),
('Aventura',10,3),
('Terror',11,3),
('Religião',12,3),
('Mistério',13,3),
('Auto-ajuda',14,3),
('RPG',15,4),
('Ação',16,4),
('Ficção Científica',17,4),
('Luta',18,4),
('Terror',19,4);

insert into produto(nome,id_subcategoria,codigo) values
('Iphone 13',1,1),
('Controle PS2',4,2),
('Calça Jeans',5,3),
('Samsung Galaxy S21', 1, 4),
('Teclado sem fio', 4, 5),
('Camiseta Polo', 7, 6),
('Mesa de escritório', 2, 7),
('Notebook Dell', 2, 8),
('Vestido Floral', 6, 9),
('Camisa Social', 7, 10);

insert into loja (nome,cnpj,email,cep,cidade,estado) values
('Fashions','11111111111111','fashioness@gmail.com','11111111','Itabaiana','SE'),
('TechZone', '22222222222222', 'techzone@gmail.com', '22222222', 'Aracaju', 'SE'),
('StylePalace', '33333333333333', 'stylepalace@gmail.com', '33333333', 'Maceió', 'AL'),
('ElectroMart', '44444444444444', 'electromart@gmail.com', '44444444', 'João Pessoa', 'PB'),
('HomeTrends', '55555555555555', 'hometrends@gmail.com', '55555555', 'Natal', 'RN'),
('BookHaven', '66666666666666', 'bookhaven@gmail.com', '66666666', 'Fortaleza', 'CE'),
('GadgetGalaxy', '77777777777777', 'gadgetgalaxy@gmail.com', '77777777', 'Teresina', 'PI'),
('SportsGear', '88888888888888', 'sportsgear@gmail.com', '88888888', 'Salvador', 'BA'),
('GreenThumb', '99999999999999', 'greenthumb@gmail.com', '99999999', 'Recife', 'PE'),
('PetParadise', '10101010101010', 'petparadise@gmail.com', '10101010', 'Areia Branca', 'SE'),
('JewelCraft', '12121212121212', 'jewelcraft@gmail.com', '12121212', 'Itabaiana', 'SE'),
('KidsEmporium', '13131313131313', 'kidsemporium@gmail.com', '13131313', 'Aracaju', 'SE'),
('FoodieFiesta', '14141414141414', 'foodiefiesta@gmail.com', '14141414', 'Maceió', 'AL');

insert into pagamento (pagamento) values 
('DEBITO'),
('CREDITO'),
('PIX'),
('BOLETO');

insert into avaliacao ()values (),(),(),(),(),();

insert into estoque (produto_id,loja_id,quantidadeEstoque) values
(1,2,25);