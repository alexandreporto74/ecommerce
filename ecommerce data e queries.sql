-- data insertion
use ecommerce;

show tables;

insert into Cliente (CNome, Cpf, Endereco, Nascimento)
		values ('Alexandre Porto', 12345678901, 'Rua A, 1', '2000-01-01'),
			('Francine Guida', 12345678902, 'Rua B, 2', '2000-01-02'),
            ('Paulo Mendes', 12345678903, 'Rua C, 3', '2000-01-03'),
            ('Maria Guimarães', 12345678904, 'Rua D, 4', '2000-01-04'),
            ('Sinesio Gurgel', 12345678905, 'Rua E, 5', '2000-01-05'),
            ('Jacy Muhlbauer', 12345678906, 'Rua F, 6', '2000-01-06'),
            ('Debora França', 12345678907, 'Rua G, 7', '2000-01-07'),
            ('Andrea Carvalho', 12345678908, 'Rua H, 8', '2000-01-08'),
            ('Thais Vieira', 12345678909, 'Rua I, 9', '2000-01-09'),
            ('Tiago Canepari', 12345678910, 'Rua J, 10', '2000-01-10');
            
select * from Cliente;

insert into Produto (PNome, Categoria, Valor)
		values ('Notebook', 'Eletrônico', 3456.78),
            ('Vestido', 'Vestuário', 123.45),
			('Calça', 'Vestuário', 234.56),
            ('Carrinho', 'Brinquedo', 12.34),
            ('Boneca', 'Brinquedo', 23.45),
            ('Arroz', 'Alimento', 23.56),
            ('Feijão', 'Alimento', 34.56),
            ('Mesa', 'Mobilia', 333.33),
            ('Cama', 'Mobilia', 444.44);
            
insert into Vendedor (Vnome, CNPJ, Endereco)
		values ('Fast', '11111111111111', 'Rua Aa, 111'),
				('Netvest', '22222222222222', 'Rua Bb, 222'),
                ('PlayKids', '33333333333333', 'Rua Cc, 333'),
                ('Foods', '44444444444444', 'Rua Dd, 444'),
                ('Cem', '55555555555555', 'Rua Ee, 555');

insert into Pedido (idPedidoCliente, Statuspedido, idPagamento)
		values (1, 2, 1),
				(2, 2, 1),
                (3, 2, 1),
                (4, 3, 1),
                (5, 3, 1),
                (6, 3, 1),
                (7, 1, 0),
                (8, 3, 1),
                (9, 3, 1),
                (10, 1, 0);
                
insert into Pagamento (TipoPagamento)
		values (1),
				(2),
                (3),
                (1),
                (2),
                (3),
                 (1),
                (2),
                (3),
                (1);
                
insert into Estoque (idEstoque, Localizacao, Quantidade)
		values (1, 'Rua A, 1', 100),
				(2, 'Rua B, 2', 200),
                (3, 'Rua C, 3', 130),
                (4, 'Rua D, 4', 10),
                (5, 'Rua E, 5', 1),
                (6, 'Rua F, 6', 0),
                (7, 'Rua G, 7', 700),
                (8, 'Rua H, 8', 300),
                (9, 'Rua I, 9', 0),
                (10, 'Rua J, 10', 400);

insert into ProdVend (idProdVend, idPvProduto, PvQuantidade)
			values (1, 1, 10),
					(1, 2, 20),
                    (2, 3, 30),
                    (2, 4, 40),
                    (3, 5, 50),
                    (3, 6, 60),
                    (4, 7, 70),
                    (4, 8, 80),
                    (5, 9, 90),
                    (5, 10, 100);
                    
insert into ProdPed (idProdPed, idPPProduto, PpQuantidade)
			values (11, 1, 5),
					(12, 2, 5),
                    (13, 3, 5),
                    (14, 4, 5),
                    (15, 5, 5),
                    (16, 6, 5),
                    (17, 7, 5),
                    (18, 8, 5),
                    (19, 9, 5),
                    (20, 10, 5);
                    
-- Queries
 -- Quantos Clientes eu tenho ?
 select count(*) from Cliente;
 
 -- Mostrar todos os pedidos dos clientes
 select * from Cliente, Pedido where idCliente = idPedidoCliente;
 select CNome, idPedido, Statuspedido from Cliente, Pedido where idCliente = idPedidoCliente;
 
 -- Quantos pedidos cada cliente fez ?
 select idCliente, CNome, count(*) as Numero_de_Ordens from Cliente
		inner join Pedido on idCliente = idPedidoCliente
	group by idCliente;
    

-- Faturamento por produto e faturamento total
select idProduto, PpQuantidade, Valor,
		(PpQuantidade * Valor) as TotalProduto
        from ProdPed inner join Produto on idPPProduto = idProduto;

select sum(PpQuantidade * Valor) as FaturamentoTotal
		from ProdPed inner join Produto on idPPProduto = idProduto;

-- Faturamento por Cliente
select idCliente, CNome, sum(PpQuantidade * Valor) as TotalCliente
		from ProdPed inner join Produto on idPPProduto = idProduto
					inner join Pedido on idProdPed = idPedido
                    inner join Cliente on idPedidoCliente = idCliente
		group by idCliente, CNome
        order by TotalCliente desc;