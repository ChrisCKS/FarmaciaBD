----------------------------------------------CLIENTES RESTRITOS-----------------------------------------------

INSERT INTO ClientesRestritos (idCliente, CPF) VALUES

(2, '12345678901'),
(4, '14785236974');

SELECT * FROM CientesRestritos;

----------------------------------------------FORNECEDORES RESTRITOS-----------------------------------------------

INSERT INTO FornecedoresRestritos (idFornecedor, CNPJ) VALUES

(2, '98765432000111'),
(5, '35795184200016');

SELECT * FROM FornecedoresRestritos;

------------------------------------------------------CLIENTES------------------------------------------------------
											
										/*DataUltimaCompra = DataVenda Venda*/
INSERT INTO Clientes (Nome, CPF, DataNasc, DataUltimaCompra, DataCadastro, Situacao) VALUES

('Christian Kevelyn', '53610828803', '2003-02-28', NULL, '2020-02-15', 1),
('Neymar Junior', '12345678901', '2009-08-20', NULL, '2021-03-16', 1),
('Lionel Messi', '98765432198', '1990-04-10', NULL, '2022-04-14', 1),				----------OK----------	
('Cristiano Ronaldo', '14785236974', '1980-05-12', NULL, '2023-06-12', 1);			/*testar dataultimacompra*/

SELECT * FROM Clientes;

------------------------------------------------------SITUA플O CLIENTE------------------------------------------------------

INSERT INTO SituacaoClientes (Situacao) VALUES
('A'),
('I');												----------OK----------				

SELECT * FROM SituacaoClientes

------------------------------------------------------TELEFONE------------------------------------------------------

INSERT INTO Telefones (idCliente, CodPais, CodArea, Numero) VALUES
(2, 55, 16, '999929938'),
(3, 55, 11, '997894561'),
(4, 55, 19, '991234567'),
(5, 55, 13, '991597538');

SELECT * FROM Telefones

------------------------------------------------------FORNECEDORES------------------------------------------------------
																/*UltimoFornecimento Recebe de UltimaCompra*/
INSERT INTO Fornecedores (CNPJ, RazaoSocial, Pais, DataAbertura, Situacao, UltimoFornecimento, DataCadastro) VALUES

('12345678000199', 'MedicinaSaude', 'Brasil', '2015-02-15', 1, NULL , '2018-04-02'),
('98765432000111', 'MaisSaude', 'Brasil', '2016-03-16', 1, NULL, '2019-05-14'),
('96385214000178', 'DrogariaMedicinal', 'Brasil', '2019-10-08', 1, NULL, '2020-06-27'),
('74185296000133', 'RemediariaMais', 'Brasil', '2018-02-14', 1, NULL, '2020-06-27'),
('35795184200016', 'DrogariaSaude', 'Brasil', '2017-08-22', 1, NULL, '2020-06-27');

SELECT * FROM Fornecedores;

------------------------------------------------------SITUA플O FORNECEDOR------------------------------------------------------

INSERT INTO SituacaoFornecedores (id, Situacao) VALUES
(1, 'A'),
(2, 'I');

SELECT * FROM SituacaoFornecedores

------------------------------------------------------PRINCIPIOS ATIVOS------------------------------------------------------
										/*DataUltimaCompra = DataCompra Comora*/
INSERT INTO PrincipiosAtivo (Nome, Situacao, DataUltimaCompra, DataCadastro) VALUES

('Principio1', 1, NULL, '2015-02-20'),
('Principio2', 1, NULL, '2016-03-21'),
('Principio3', 1, NULL, '2017-04-22'),
('Principio4', 1, NULL, '2018-05-23');

SELECT * FROM PrincipiosAtivo;

-------------------------------------------------SITUA플O PRICIPIOS ATIVO------------------------------------------------------

INSERT INTO SituacaoPrincipiosAtivo (id, Situacao) VALUES
(1, 'A'),
(2, 'I');

SELECT * FROM SituacaPrincipioAtivo

------------------------------------------------------MEDICAMENTOS------------------------------------------------------			

							/*ValorVenda = ValorUnitario*/	/*UltimaVenda = DataVenda Venda*/
INSERT INTO Medicamentos (CDB, ValorVenda, Nome, UltimaVenda, DataCadastro, Situacao, Categoria) VALUES

('1472583691598', '25.00', 'Nelsaldina', NULL, '2010-10-30', 1, 'A'),
('1597536984562', '50.00', 'Paracetamol', NULL, '2011-09-29', 1, 'B'),
('78963214753951', '100.00', 'Dorflex', NULL, '2011-08-28', 1, 'I'),
('36987412357951', '200.00', 'Dramim', NULL, '2011-07-27', 1, 'V');

SELECT * FROM Medicamentos;

------------------------------------------------------SITUA플O MEDICAMENTO------------------------------------------------------

INSERT INTO SituacaoMed (id, Situacao) VALUES
(1, 'A'),
(2, 'I');

SELECT * FROM SituacaoMed

------------------------------------------------------CATEGORIA DO MEDICAMENTO------------------------------------------------

INSERT INTO CategoriasMed (id, Categoria) VALUES
(1, 'A'),
(2, 'B'),
(3, 'I'),
(4, 'V');

SELECT * FROM CategoriasMed


------------------------------------------------------VENDAS------------------------------------------------------

				/*ValorTotal = Soma de TotalItemVenda*/
INSERT INTO Vendas (idCliente, DataVenda, ValorTotal) VALUES	/*Atributo idCliente sendo informado*/

(1, '2025-01-10', NULL),
(2, '2025-02-11', NULL),
(3, '2025-03-12', NULL),
(2, '2025-04-13', NULL);

SELECT * FROM Vendas;

----------------------------------------------------ITENS VENDA------------------------------------------------------	

/*ValorUnitario = ValorVenda Medicamento*/ /*TotalItem = Qntd * ValorUnitario*/
INSERT INTO ItensVenda (Quantidade, idVenda, CDB, ValorUnitario, TotalItem) VALUES
/*idVenda e CDB sendo trazidos*/

(2, 1, '1472583691598', NULL, NULL), 
(3, 2, '1597536984562', NULL, NULL),
(4, 3, '78963214753951', NULL, NULL),
(5, 4, '36987412357951', NULL, NULL);

SELECT * FROM ItensVenda VALUES

------------------------------------------------------COMPRAS------------------------------------------------------

						/*ValorTotal = Soma TotalItemCompra*/
INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES	/*Atributo IdFornecedor sendo atribuido aqui*/

(1, '2025-01-10', NULL),
(2, '2025-02-11', NULL),
(3, '2025-03-12', NULL),
(4, '2025-04-13', NULL);

SELECT * FROM Compras;

---------------------------------------------------ITENS DE COMPRA---------------------------------------------------	

/*TotalItem = Quantidade * ValorUnitario*/
INSERT INTO ItensCompras (idCompra, idPrincipioAt, Quantidade, ValorUnitario, TotalItem) VALUES
/*Atributo IdCompra sendo atribuido aqui, IdPrincipioAtivo Tambem*/

(1, 1, 2, '5.00', NULL),
(2, 2, 3, '10.00', NULL),
(3, 3, 4, '20.00', NULL),
(4, 4, 5, '30.00', NULL);

SELECT * FROM ItensCompras;

------------------------------------------------------PRODU플O------------------------------------------------------

INSERT INTO Producoes (DataProducao, CDB, Quantidade) VALUES	/*CDB sendo trazido*/

('2025-01-01', '1472583691598', 5),
('2025-02-02', '1597536984562', 10),
('2025-03-03', '78963214753951', 15),
('2025-02-02', '36987412357951', 20);

SELECT * FROM Producoes;

------------------------------------------------------ITENS DA PRODU플O-------------------------------------------------

INSERT INTO ItensProducoes (idProducao, idPrincipioAt, Quantidade) VALUES	/*Atribuindo IdProdu豫o e IdPrincipioAtivo*/

(1, 1, 20),
(2, 2, 15),
(3, 3, 10),
(4, 4, 5);

SELECT * FROM ItensProducoes;
