----------------------------------------------CLIENTES RESTRITOS-----------------------------------------------

INSERT INTO ClientesRestritos (idCliente, CPF) VALUES

(2),
(4);							--AINDA NAO MEXI

SELECT * FROM CientesRestritos;

----------------------------------------------FORNECEDORES RESTRITOS-----------------------------------------------

INSERT INTO FornecedoresRestritos (idFornecedor, CNPJ) VALUES

(2),						--AINDA NAO MEXI
(5);

SELECT * FROM FornecedoresRestritos;

------------------------------------------------------CLIENTES------------------------------------------------------
											
										/*DataUltimaCompra = DataVenda Venda*/
INSERT INTO Clientes (Nome, CPF, DataNasc, DataUltimaCompra, DataCadastro, Situacao) VALUES

('Christian Kevelyn', '53610828803', '2003-02-28', NULL, '2020-02-15', 1),
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

------------------------------------------------------SITUAÇÃO FORNECEDOR------------------------------------------------------

INSERT INTO SituacaoFornecedores (Situacao) VALUES
('A'),
('I');																					

SELECT * FROM SituacaoFornecedores

------------------------------------------------------PRINCIPIOS ATIVOS------------------------------------------------------
										/*DataUltimaCompra = DataCompra Comora*/
INSERT INTO PrincipiosAtivo (Nome, Situacao, DataUltimaCompra, DataCadastro) VALUES

('Principio1', 1, NULL, '2015-02-20'),
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
('1597536984562', '50.00', 'Paracetamol', NULL, '2011-09-29', 1, 2),	/*pensar em trazer as siglas e não os Ids de sitaçao e categorias*/
('7896321475395', '100.00', 'Dorflex', NULL, '2011-08-28', 1, 3),
('3698741235795', '200.00', 'Dramim', NULL, '2011-07-27', 1, 4);

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

(2, '2025-02-10', NULL),
(3, '2025-03-11', NULL),
(4, '2025-04-12', NULL),					
(5, '2025-05-13', NULL);

SELECT * FROM Vendas;

----------------------------------------------------ITENS VENDA------------------------------------------------------	

/*ValorUnitario = ValorVenda Medicamento*/ /*TotalItem = Qntd * ValorUnitario*/
INSERT INTO ItensVendas (Quantidade, idVenda, CDB, ValorUnitario) VALUES
/*idVenda e CDB sendo trazidos*/

(2, 1, '1472583691598', NULL),			
(3, 2, '1597536984562', NULL),
(4, 3, '7896321475395', NULL),			/*TotalItem esta como NULL pois o valorUnitario precisa vim de valor venda*/
(5, 4, '3698741235795', NULL);

SELECT * FROM ItensVendas c

------------------------------------------------------COMPRAS------------------------------------------------------

						/*ValorTotal = Soma TotalItemCompra*/
INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal) VALUES	/*Atributo IdFornecedor sendo atribuido aqui*/

(3, '2025-10-10', NULL),
(4, '2025-09-11', NULL),
(5, '2025-08-12', NULL),				
(6, '2025-07-13', NULL);

SELECT * FROM Compras;

---------------------------------------------------ITENS DE COMPRA---------------------------------------------------	

/*TotalItem = Quantidade * ValorUnitario*/
INSERT INTO ItensCompras (idCompra, idPrincipioAt, Quantidade, ValorUnitario) VALUES
/*Atributo IdCompra sendo atribuido aqui, IdPrincipioAtivo Tambem*/

(1, 1, 2, '5.00'),
(2, 2, 3, '10.00'),				
(3, 3, 4, '20.00'),				/*Aqui total item ja está calculando*/
(4, 4, 5, '30.00');

SELECT * FROM ItensCompras;

------------------------------------------------------PRODUÇÃO------------------------------------------------------

INSERT INTO Producoes (DataProducao, CDB, Quantidade) VALUES	/*CDB sendo trazido*/

('2025-01-01', '1472583691598', 5),
('2025-02-02', '1597536984562', 10),
('2025-03-03', '7896321475395', 15),						
('2025-02-02', '3698741235795', 20);

SELECT * FROM Producoes;

------------------------------------------------------ITENS DA PRODUÇÃO-------------------------------------------------

INSERT INTO ItensProducoes (idProducao, idPrincipioAt, Quantidade) VALUES	/*Atribuindo IdProdução e IdPrincipioAtivo*/

(1, 1, 20),
(2, 2, 15),
(3, 3, 10),
(4, 4, 5);

SELECT * FROM ItensProducoes;

/* ================================ATUALIZAR DATA DA ULTIMA COMPRA DO CLIENTE======================= */

CREATE TRIGGER trg_AtualizaUltimaCompra		/*Rotina executada automaticamente*/
ON Vendas									/*sempre que ocorrer INSERT, UPDATE OU DELETE na tabela Vendas, a TRIGGER podera ser executada*/
AFTER INSERT								/*TRIGGER sera executada "depois" da "inserção"*/
AS BEGIN									/*Inicio do código que sera executado quando a TRIGGER for disparada*/
    UPDATE Clientes							/*Atualiza a tabela Clientes*/
    SET DataUltimaCompra = i.DataVenda		/*DataUltimaCompra será atualizado com a DataVenda vinda da tabela virtual "inserted"*/
    FROM Clientes c
    JOIN inserted i ON c.idCliente = i.idCliente; /*liga a tabela inserted com a tabela cliente, e por fim atualize apenas o cliente que fez a venda*/
END;												 /*e por fim atualize apenas o cliente que fez a venda*/
GO

/* ================================ATUALIZAR ULTIMO FORNECIMENTO DO FORNECEDOR======================= */

CREATE TRIGGER trg_AtualizaUltimoFornecimento
ON Compras
AFTER INSERT
AS BEGIN
    UPDATE Fornecedores
    SET UltimoFornecimento = i.DataCompra
    FROM Fornecedores f
    JOIN inserted i ON f.idFornecedor = i.idFornecedor;
END;
GO

/* ================================NAO PODE COMPRAR DE FORNECEDOR BLOQUEADO OU INATIVO======================= */

CREATE TRIGGER trg_Fornecedor_RestritoInativoCompra
ON Compras
INSTEAD OF INSERT                                                               /*quando executa um INSERT em Compras, o codigo do trigger é executado no lugar do INSERT original*/
AS BEGIN
--- Verifica se o fornecedor está bloq---
    IF EXISTS (                                                                  /*se existir pelo menos 1 registro que satisfaça a consulta interna*/
        SELECT 1                                                                 /*somente para checar existência*/
        FROM inserted i                                                          /*tabela virtual criada que contes o que foi enviado do INSERT */
        JOIN FornecedoresRestritos r ON r.idFornecedor = i.idFornecedor             /*junta as linhas de INSERTED com a tabela de restritos*/
    )
    BEGIN                                                                          /*quando a condição for verdadeira:*/
        ROLLBACK TRANSACTION;                                                      /*aqui ele cancela a transação, se a compra estiver sendo feita com fornecedor bloq*/
        THROW 50001, 'Fornecedor bloqueado — compra não permitida.', 1;
    END;

--- Verifica se o fornecedor está inativo---
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Fornecedores f ON f.idFornecedor = i.idFornecedor
        JOIN SituacaoFornecedores s ON f.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50023, 'Fornecedor inativo — não é possível registrar compra.', 1;
    END;

    INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal)                      /*se o fornecdor nao estava bloq, executa normalmente*/
    SELECT idFornecedor, DataCompra, ValorTotal                                     /*pega os dados da tabela virtual que foram inseridos e insere na tabela real*/
    FROM inserted;
END;
GO

/* ================================CLIENTE BLOQUEADO OU INATIVO NÃO PODE COMPRAR======================= */

CREATE TRIGGER trg_Cliente_RestritoInativoVenda
ON Vendas
INSTEAD OF INSERT
AS BEGIN
--- Verifica se o cliente está bloq---
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN ClientesRestritos r ON r.idCliente = i.idCliente
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50020, 'Cliente restrito — venda não permitida.', 1;
        RETURN;
    END;

--- Verifica se o cliente está inativo---
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Clientes c ON c.idCliente = i.idCliente
        JOIN SituacaoClientes s ON c.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50021, 'Cliente inativo — não é possível registrar venda.', 1;
        RETURN;
    END;
    
    INSERT INTO Vendas (idCliente, DataVenda, ValorTotal)
    SELECT idCliente, DataVenda, ValorTotal
    FROM inserted;
END;
GO

    /* ================================PRINCIPIO ATIVO "INATIVO" EM COMPRA======================= */

CREATE TRIGGER trg_PrincipioInativo_Compra
ON ItensCompras
INSTEAD OF INSERT
AS BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN PrincipiosAtivo p ON p.idPrincipioAt = i.idPrincipioAt
        JOIN SituacaoPrincipiosAtivo s ON p.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50012, 'O Princípio ativo esta como inativo — não pode ser comprado.', 1;
    END;

    INSERT INTO ItensCompras (idCompra, idPrincipioAt, Quantidade, ValorUnitario)
    SELECT idCompra, idPrincipioAt, Quantidade, ValorUnitario
    FROM inserted;
END;
GO

/* ================================PRINCIPIO ATIVO "INATIVO" EM PRODUÇÃO======================= */

CREATE TRIGGER trg_PrincipioInativo_Producao
ON ItensProducoes
INSTEAD OF INSERT
AS BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN PrincipiosAtivo p ON p.idPrincipioAt = i.idPrincipioAt
        JOIN SituacaoPrincipiosAtivo s ON p.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50013, 'Princípio ativo esta como inativo — não pode ser usado na produção.', 1;
    END;

    INSERT INTO ItensProducoes (idProducao, idPrincipioAt, Quantidade)
    SELECT idProducao, idPrincipioAt, Quantidade
    FROM inserted;
END;
GO

    /* ================================MEDICAMENTO "INATIVO" EM VENDA======================= */

CREATE TRIGGER trg_Medicamento_Inativo_Venda
ON ItensVendas
INSTEAD OF INSERT
AS BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Medicamentos m ON m.CDB = i.CDB
        JOIN SituacaoMed s ON m.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50014, 'Medicamento inativo — não pode ser vendido.', 1;
    END;

    INSERT INTO ItensVendas (Quantidade, idVenda, CDB, ValorUnitario)
    SELECT Quantidade, idVenda, CDB, ValorUnitario
    FROM inserted;
END;
GO

/* ================================MEDICAMENTO "INATIVO" EM PRODUÇÃO======================= */

CREATE TRIGGER trg_Medicamento_Inativo_Producao
ON Producoes
INSTEAD OF INSERT
AS BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Medicamentos m ON m.CDB = i.CDB
        JOIN SituacaoMed s ON m.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50015, 'Medicamento inativo — não pode ser produzido.', 1;
    END;

    INSERT INTO Producoes (DataProducao, CDB, Quantidade)
    SELECT DataProducao, CDB, Quantidade
    FROM inserted;
END;
GO

