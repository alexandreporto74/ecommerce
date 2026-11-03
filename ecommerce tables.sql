-- criar cenario de database ecommerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table Cliente(
		idCliente int auto_increment primary key,
        CNome varchar(45),
        Cpf char(11) not null,
        Endereco varchar(45),
        Nascimento date,
        constraint unique_cpf_cliente unique (Cpf)
);
alter table Cliente auto_increment=1;

-- criar tabela Produto

create table Produto(
		idProduto int primary key not null auto_increment,
        PNome varchar(45),
        Categoria enum('Eletrônico','Vestuário','Brinquedo','Alimento','Mobilia') not null,
        Endereco varchar(45),
        Valor decimal(10, 2) not null
);
alter table Produto auto_increment=1;

-- criar tabela Vendedor

create table Vendedor(
		idVendedor int auto_increment primary key,
        VNome varchar(45),
        CNPJ char(14) not null,
        Endereco varchar(45),
        constraint unique_cnpj_vendedor unique (CNPJ)
);
alter table Vendedor auto_increment=1;

-- criar tabela Pedido

create table Pedido(
		idPedido int primary key not null auto_increment,
        idPedidoCliente int,
        Statuspedido enum('Cancelado','Confirmado','Em Processamento') not null,
        idPagamento int,
        constraint fk_cliente_pedido foreign key (idPedidoCliente) references Cliente(idCliente)
);
alter table Pedido auto_increment=1;

-- criar tabela Pagamento
create table Pagamento(
		idPgtoPedido int,
        idPagamento int auto_increment not null primary key,
        TipoPagamento enum('Boleto','Cartão','Pix'),
        constraint fk_PgtoPedido_Pedido foreign key (idPgtoPedido) references Pedido(idPedido)
);

alter table Pagamento auto_increment=1;

-- criar tabela estoque

create table Estoque(
		idEstoque int primary key,
        Localizacao varchar(255),
        Quantidade int default 0,
        constraint fk_produto_estoque foreign key (IdEstoque) references Produto(idProduto)
);

-- criar tabela ProdutoVendedor

create table ProdVend(
		idProdVend int,
        idPvProduto int,
        PvQuantidade int,
        primary key (IdProdVend, idPvProduto),
        constraint fk_produtovendedor foreign key (idProdVend) references Vendedor(idVendedor),
		constraint fk_vendedorproduto foreign key (idPvProduto) references Produto(idProduto)
);

-- criar tabela ProdutoPedido

create table ProdPed(
		idProdPed int,
        idPPProduto int,
        PpQuantidade int,
        primary key (IdProdPed, idPPProduto),
        constraint fk_produtopedido foreign key (idProdPed) references Pedido(idPedido),
		constraint fk_pedidoproduto foreign key (idPPProduto) references Produto(idProduto)
);