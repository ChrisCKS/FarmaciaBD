----------------------------------------------CLIENTES RESTRITOS-----------------------------------------------

INSERT INTO ClientesRestritos (idCliente) VALUES

(2);							

SELECT * FROM ClientesRestritos;

----------------------------------------------FORNECEDORES RESTRITOS-----------------------------------------------

INSERT INTO FornecedoresRestritos (idFornecedor) VALUES

(1);			

SELECT * FROM FornecedoresRestritos;

------------------------------------------------------CLIENTES------------------------------------------------------
											
										/*DataUltimaCompra = DataVenda Venda*/
INSERT INTO Clientes (Nome, CPF, DataNasc, DataUltimaCompra, DataCadastro, Situacao) VALUES

('Christian Kevelyn', '53610828803', '2003-02-28', NULL, '2020-02-15', 2),
('Neymar Junior', '12345678901', '2009-08-20', NULL, '2021-03-16', 1),
('Lionel Messi', '98765432198', '1990-04-10', NULL, '2022-04-14', 1),				
('Cristiano Ronaldo', '14785236974', '1980-05-12', NULL, '2023-06-12', 1);			

SELECT * FROM Clientes;

------------------------------------------------------SITUAÇÃO CLIENTE------------------------------------------------------

INSERT INTO SituacaoClientes (Situacao) VALUES
('A'),
('I');															

SELECT * FROM SituacaoClientes

------------------------------------------------------TELEFONE------------------------------------------------------

INSERT INTO Telefones (idCliente, CodPais, CodArea, Numero) VALUES
(2, 55, 16, '999929938'),
(3, 55, 11, '997894561'),
(4, 55, 19, '991234567'),									
(1, 55, 13, '991597538');

SELECT * FROM Telefones

------------------------------------------------------FORNECEDORES------------------------------------------------------
																/*UltimoFornecimento Recebe de UltimaCompra*/
INSERT INTO Fornecedores (CNPJ, RazaoSocial, Pais, DataAbertura, Situacao, UltimoFornecimento, DataCadastro) VALUES

('12345678000199', 'MedicinaSaude', 'Brasil', '2024-02-15', 1, NULL , '2018-04-02'),
('98765432000111', 'MaisSaude', 'Brasil', '2016-03-16', 2, NULL, '2019-05-14'),
('96385214000178', 'DrogariaMedicinal', 'Brasil', '2019-10-08', 1, NULL, '2020-06-27'),				
('74185296000133', 'RemediariaMais', 'Brasil', '2018-02-14', 1, NULL, '2020-06-27'),
('35795184200016', 'DrogariaSaude', 'Brasil', '2017-08-22', 1, NULL, '2020-06-27');

UPDATE Fornecedores
SET DataAbertura = '2024-02-15'
WHERE idFornecedor = 3;

SELECT * FROM Fornecedores;

------------------------------------------------------SITUAÇÃO FORNECEDOR------------------------------------------------------

INSERT INTO SituacaoFornecedores (Situacao) VALUES
('A'),
('I');																					

SELECT * FROM SituacaoFornecedores

------------------------------------------------------PRINCIPIOS ATIVOS------------------------------------------------------
										/*DataUltimaCompra = DataCompra Comora*/
INSERT INTO PrincipiosAtivo (Nome, Situacao, DataUltimaCompra, DataCadastro) VALUES

('Principio1', 2, NULL, '2015-02-20'),
('Principio2', 1, NULL, '2016-03-21'),
('Principio3', 1, NULL, '2017-04-22'),									
('Principio4', 1, NULL, '2018-05-23');

SELECT * FROM PrincipiosAtivo;

-------------------------------------------------SITUAÇÃO PRICIPIOS ATIVO------------------------------------------------------

INSERT INTO SituacaoPrincipiosAtivo (Situacao) VALUES
('A'),
('I');															

SELECT * FROM SituacaoPrincipiosAtivo

------------------------------------------------------MEDICAMENTOS------------------------------------------------------			

							/*ValorVenda = ValorUnitario*/	/*UltimaVenda = DataVenda Venda*/
INSERT INTO Medicamentos (CDB, ValorVenda, Nome, UltimaVenda, DataCadastro, Situacao, Categoria) VALUES

('1472583691598', '25.00', 'Nelsaldina', NULL, '2010-10-30', 1, 1),				
('1597536984562', '50.00', 'Paracetamol', NULL, '2011-09-29', 1, 2),	
('7896321475395', '100.00', 'Dorflex', NULL, '2011-08-28', 1, 3),
('3698741235795', '200.00', 'Dramim', NULL, '2011-07-27', 2, 4);

SELECT * FROM Medicamentos;

------------------------------------------------------SITUAÇÃO MEDICAMENTO------------------------------------------------------

INSERT INTO SituacaoMed (Situacao) VALUES
('A'),
('I');												

SELECT * FROM SituacaoMed

------------------------------------------------------CATEGORIA DO MEDICAMENTO------------------------------------------------

INSERT INTO CategoriasMed (Categoria) VALUES
('A'),
('B'),
('I'),											
('V');

SELECT * FROM CategoriasMed


------------------------------------------------------VENDAS------------------------------------------------------

				/*ValorTotal = Soma de TotalItemVenda*/
INSERT INTO Vendas (idCliente, DataVenda, ValorTotal) VALUES	/*Atributo idCliente sendo informado*/
(3, '2025-03-11', NULL),
(4, '2025-04-12', NULL);					

INSERT INTO Vendas (idCliente, DataVenda, ValorTotal) VALUES    /*Cliente INATIVO*/
(1, '2025-05-13', NULL);

INSERT INTO Vendas (idCliente, DataVenda, ValorTotal) VALUES    /*Cliente menor de idade*/
(2, '2025-02-10', NULL);

SELECT * FROM Vendas;

----------------------------------------------------ITENS VENDA------------------------------------------------------	

/*ValorUnitario = ValorVenda Medicamento*/ /*TotalItem = Qntd * ValorUnitario*/
INSERT INTO ItensVendas (Quantidade, idVenda, CDB, ValorUnitario) VALUES
/*idVenda e CDB sendo trazidos*/

(2, 1, '1472583691598', NULL),	
(3, 2, '1597536984562', NULL),  
(4, 2, '7896321475395', NULL);	/*TotalItem esta como NULL pois o valorUnitario precisa vim de valor venda*/

INSERT INTO ItensVendas (Quantidade, idVenda, CDB, ValorUnitario) VALUES
(5, 4, '3698741235795', NULL);      /*Medicamento Inativo*/
        

SELECT * FROM ItensVendas

------------------------------------------------------COMPRAS------------------------------------------------------

						/*ValorTotal = Soma TotalItemCompra*/
INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES	/*Atributo IdFornecedor sendo atribuido aqui*/

(4, '2025-09-11', NULL),
(5, '2025-08-12', NULL),	
(4, '2025-09-15', NULL);

INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES
(1, '2025-06-20', NULL);    /*RESTRITO*/

INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES
(2, '2025-07-13', NULL);  /*INATIVO*/

INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES
(3, '2025-10-10', NULL); /*MENOS DE 2 ANOS DE ABERTURA*/

SELECT * FROM Compras;

---------------------------------------------------ITENS DE COMPRA---------------------------------------------------	

/*TotalItem = Quantidade * ValorUnitario*/
INSERT INTO ItensCompras (idCompra, idPrincipioAt, Quantidade, ValorUnitario) VALUES
/*Atributo IdCompra sendo atribuido aqui, IdPrincipioAtivo Tambem*/

(2, 2, 3, '10.00'),				
(3, 3, 4, '20.00');		/*Aqui total item ja está calculando*/

INSERT INTO ItensCompras (idCompra, idPrincipioAt, Quantidade, ValorUnitario) VALUES
(1, 1, 2, '5.00');			/*Principio Inativo*/

SELECT * FROM ItensCompras;

------------------------------------------------------PRODUÇÃO------------------------------------------------------

INSERT INTO Producoes (DataProducao, CDB, Quantidade) VALUES	/*CDB sendo trazido*/

('2025-01-01', '1472583691598', 5),
('2025-02-02', '1597536984562', 10),
('2025-03-03', '7896321475395', 15);					

INSERT INTO Producoes (DataProducao, CDB, Quantidade) VALUES    /*Medicamento INATIVO*/
('2025-02-02', '3698741235795', 20);

SELECT * FROM Producoes;

------------------------------------------------------ITENS DA PRODUÇÃO-------------------------------------------------

INSERT INTO ItensProducoes (idProducao, idPrincipioAt, Quantidade) VALUES	/*Atribuindo IdProdução e IdPrincipioAtivo*/

(2, 2, 15),
(3, 3, 10);

INSERT INTO ItensProducoes (idProducao, idPrincipioAt, Quantidade) VALUES	/*Atribuindo IdProdução e IdPrincipioAtivo*/			
(1, 1, 20);	/*Principio Inativo*/

SELECT * FROM ItensProducoes;


/*SELECT DB_NAME() AS BancoAtual;

SELECT name, parent_class_desc, type_desc
FROM sys.triggers
WHERE parent_id = OBJECT_ID('ItensProducoes');

SELECT name, parent_class_desc, type_desc, OBJECT_NAME(parent_id) AS Tabela
FROM sys.triggers
ORDER BY Tabela;*/
