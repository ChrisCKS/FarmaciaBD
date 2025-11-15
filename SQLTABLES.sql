--         <<   Criar Banco de Dados   >>
CREATE DATABASE SneezePharma;
GO

USE SneezePharma
GO

CREATE TABLE SituacaoClientes(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Situacao CHAR(1) NOT NULL
);

CREATE TABLE SituacaoMed(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Situacao CHAR(1) NOT NULL
);

CREATE TABLE SituacaoPrincipiosAtivo(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Situacao CHAR(1) NOT NULL
);

CREATE TABLE SituacaoFornecedores(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Situacao CHAR(1) NOT NULL
);

CREATE TABLE CategoriasMed(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Categoria CHAR(1) NOT NULL
);

CREATE TABLE Clientes(
	idCliente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR(50) NOT NULL,
	CPF CHAR(11) NOT NULL UNIQUE,
	DataNasc DATE NOT NULL,
	DataUltimaCompra DATE,
	DataCadastro DATE NOT NULL,
	Situacao INT NOT NULL
);

CREATE TABLE Telefones(
	idTelefone INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idCliente INT NOT NULL,
	CodPais INT NOT NULL,
	CodArea INT NOT NULL,
	Numero NVARCHAR(20) NOT NULL
);

CREATE TABLE ClientesRestritos(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idCliente INT NOT NULL UNIQUE
);

CREATE TABLE Fornecedores(
	idFornecedor INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	CNPJ CHAR(14) NOT NULL UNIQUE,
	RazaoSocial VARCHAR(50) NOT NULL,
	Pais VARCHAR(20) NOT NULL,
	DataAbertura DATE NOT NULL,
	Situacao INT NOT NULL,
	UltimoFornecimento DATE,
	DataCadastro DATE NOT NULL
);

CREATE TABLE FornecedoresRestritos(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idFornecedor INT NOT NULL UNIQUE
);

CREATE TABLE Vendas(
	idVenda INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idCliente INT NOT NULL,
	DataVenda DATE NOT NULL,
	ValorTotal DECIMAL(7,2)
);

CREATE TABLE Medicamentos(
	CDB NUMERIC(13,0) NOT NULL PRIMARY KEY,
	ValorVenda DECIMAL(6,2) NOT NULL,
	Nome VARCHAR(40) NOT NULL,
	UltimaVenda DATE,
	DataCadastro DATE NOT NULL,
	Situacao INT NOT NULL,
	Categoria INT NOT NULL
);

CREATE TABLE ItensVendas(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Quantidade INT NOT NULL,
	idVenda INT NOT NULL,
	CDB NUMERIC(13,0) NOT NULL,
	ValorUnitario DECIMAL(6,2),
	TotalItem AS (CAST(Quantidade * ValorUnitario AS DECIMAL(7,2))) PERSISTED  -- atributo derivado | CAST=converter_Tipo e PERSISTED=armazenar
);

CREATE TABLE Producoes(
	idProducao INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	DataProducao DATE NOT NULL,
	CDB NUMERIC(13,0) NOT NULL,
	Quantidade INT NOT NULL
);

CREATE TABLE PrincipiosAtivo(
	idPrincipioAt INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR(20) NOT NULL,
	Situacao INT NOT NULL,
	DataUltimaCompra DATE,
	DataCadastro DATE NOT NULL
);

CREATE TABLE ItensProducoes(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idProducao INT NOT NULL,
	idPrincipioAt INT NOT NULL,
	Quantidade INT NOT NULL
);

CREATE TABLE Compras(
	idCompra INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idFornecedor INT NOT NULL,
	DataCompra DATE NOT NULL,
	ValorTotal DECIMAL(7,2)
);

CREATE TABLE ItensCompras(
	id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	idCompra INT NOT NULL,
	idPrincipioAt INT NOT NULL,
	Quantidade INT NOT NULL,
	ValorUnitario DECIMAL(5,2) NOT NULL,
	TotalItem AS (CAST(Quantidade * ValorUnitario AS DECIMAL(7,2))) PERSISTED
);
GO

--         >>   Alterando Tabelas (Adicionado Constraints)   <<
ALTER TABLE Medicamentos
ADD CONSTRAINT Chk_venda_positivo CHECK (ValorVenda > 0)  -- Uma restri��o em que a venda deve ser positivo
GO

ALTER TABLE ItensCompras
ADD CONSTRAINT Chk_compra_positivo CHECK (ValorUnitario > 0)  -- Uma restri��o em que a compra deve ser positivo
GO

--         >>   Cria��o dos Relacionamento entre tabelas   <<
ALTER TABLE Telefones
ADD FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
GO
ALTER TABLE Clientes
ADD FOREIGN KEY (Situacao) REFERENCES SituacaoClientes(id)
GO
ALTER TABLE ClientesRestritos
ADD FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
GO
ALTER TABLE Vendas
ADD FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
GO
ALTER TABLE ItensVendas
ADD FOREIGN KEY (idVenda) REFERENCES Vendas(idVenda),
FOREIGN KEY (CDB) REFERENCES Medicamentos(CDB)
GO
ALTER TABLE Medicamentos
ADD FOREIGN KEY (Situacao) REFERENCES SituacaoMed(id),
FOREIGN KEY (Categoria) REFERENCES CategoriasMed(id)
GO
ALTER TABLE Producoes
ADD FOREIGN KEY (CDB) REFERENCES Medicamentos(CDB)
GO
ALTER TABLE ItensProducoes
ADD FOREIGN KEY (idProducao) REFERENCES Producoes(idProducao),
FOREIGN KEY (idPrincipioAt) REFERENCES PrincipiosAtivo(idPrincipioAt)
GO
ALTER TABLE PrincipiosAtivo
ADD FOREIGN KEY (Situacao) REFERENCES SituacaoPrincipiosAtivo(id)
GO
ALTER TABLE ItensCompras
ADD FOREIGN KEY (idPrincipioAt) REFERENCES PrincipiosAtivo(idPrincipioAt),
FOREIGN KEY (idCompra) REFERENCES Compras(idCompra)
GO
ALTER TABLE Compras
ADD FOREIGN KEY (idFornecedor) REFERENCES Fornecedores(idFornecedor)
GO
ALTER TABLE Fornecedores
ADD FOREIGN KEY (Situacao) REFERENCES SituacaoFornecedores(id)
GO
ALTER TABLE FornecedoresRestritos
ADD FOREIGN KEY (idFornecedor) REFERENCES Fornecedores(idFornecedor)
GO

--         >>   Cria��o de Triggers para Impedir o DELETE   <<<
CREATE TRIGGER Trg_ImpedirDelete_SituacaoClientes
ON SituacaoClientes
INSTEAD OF DELETE   -- INSTEAD OF = aciona a trigger antes da opera��o DELETE 
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_SituacaoMed
ON SituacaoMed
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_SituacaoPrincipiosAtivo
ON SituacaoPrincipiosAtivo
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_SituacaoFornecedores
ON SituacaoFornecedores
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_CategoriasMed
ON CategoriasMed
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Clientes
ON Clientes
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Telefones
ON Telefones
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Fornecedores
ON Fornecedores
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Vendas
ON Vendas
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Medicamentos
ON Medicamentos
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_ItensVendas
ON ItensVendas
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Producoes
ON Producoes
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_PrincipiosAtivo
ON PrincipiosAtivo
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_ItensProducoes
ON ItensProducoes
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_Compras
ON Compras
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

CREATE TRIGGER Trg_ImpedirDelete_ItensCompras
ON ItensCompras
INSTEAD OF DELETE
AS BEGIN
	SET NOCOUNT ON;
	THROW 51000, 'DELETE n�o � permitida nesta tabela.', 1;
END;
GO

--         >>   Cria��o de Triggers para outras funcionalidades   <<< 
CREATE TRIGGER Trg_PreencherValorUnitario
ON ItensVendas
AFTER INSERT
AS BEGIN
    SET NOCOUNT ON;
    UPDATE iv
    SET iv.ValorUnitario = m.ValorVenda    -- Aqui ele faz a c�pia do valor e atrbui a ValorUnitario
    FROM ItensVendas iv
    JOIN inserted i 
	ON iv.id = i.id
    JOIN Medicamentos m
	ON i.CDB = m.CDB
    WHERE iv.ValorUnitario IS NULL;
END;
GO

CREATE TRIGGER Trg_Limita_ItensPorVenda
ON ItensVendas
AFTER INSERT
AS BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1                  /*retorna verdadeiro se houver pelo menos uma venda que, após o INSERT,tenha mais de 3 itens.*/
        FROM ItensVendas iv              /*junta a tabela ItensVendas*/
        JOIN inserted i                 /*com as linhas recem inseridas na tabela virtual inserted*/
        ON iv.idVenda = i.idVenda       /*agrupando por idVenda*/
        GROUP BY iv.idVenda             /*agrupa resultados por cada venda*/
        HAVING COUNT(iv.idVenda) > 3    /*filtra vendas cuja quantidade de itens seja maior que 3.*/
    )
    BEGIN
	    ROLLBACK TRANSACTION;           /*desfaz toda a transação*/
        THROW 51001, 'Uma venda n�o pode conter mais de 3 itens.', 1;
    END;
END;
GO

CREATE TRIGGER Trg_PreencherValorTotaldaVenda
ON ItensVendas
AFTER INSERT, UPDATE        /*Dispara com uma inserção ou atualização*/
AS BEGIN
    SET NOCOUNT ON;
    UPDATE v                                        /*indica que a prox operação sera uma atualização na tabela vemdas(v)*/
    SET v.ValorTotal = (SELECT SUM(iv.TotalItem)    /*Recalcula o ValorTotal*/ /*atribui a soma dos itens(TotalItem)*/
        FROM ItensVendas iv
        WHERE iv.idVenda = v.idVenda                /*daquela venda específica*/
    )
    FROM Vendas v                               /*especifica que a alteração sera feita nesta tabela*/
    JOIN (SELECT DISTINCT idVenda               /*DISTINCT evita duplicatas*/
	FROM inserted
    ) 
	AS i ON v.idVenda = i.idVenda;
END;
GO

CREATE TRIGGER Trg_Limita_ItensPorCompra
ON ItensCompras
AFTER INSERT
AS BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1
        FROM ItensCompras ic
        JOIN inserted i ON ic.idCompra = i.idCompra
        GROUP BY ic.idCompra
        HAVING COUNT(ic.idCompra) > 3
    )
    BEGIN
	    ROLLBACK TRANSACTION;
        THROW 51001, 'Uma compra n�o pode conter mais de 3 itens.', 1;
    END;
END;
GO

CREATE TRIGGER Trg_PreencherValorTotaldaCompra
ON ItensCompras
AFTER INSERT, UPDATE
AS BEGIN
    SET NOCOUNT ON;
    UPDATE c
    SET c.ValorTotal = (SELECT SUM(ic.TotalItem)
        FROM ItensCompras ic
        WHERE ic.idCompra = c.idCompra
    )
    FROM Compras c
    JOIN (SELECT DISTINCT idCompra
	FROM inserted
    ) 
	AS i ON c.idCompra = i.idCompra;
END;
GO

/*================VERIFICAÇÕES PARA O CLIENTE===================*/



CREATE TRIGGER trg_Cliente_RestritoInativoMaiorIdade
ON Vendas
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

------------Verifica se o cliente está na lista de restritos

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

----------------------Verifica se o cliente está inativo

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

-----------------Verifica se o cliente tem menos de 18 anos

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Clientes c ON i.idCliente = c.idCliente
        WHERE 
            DATEDIFF(YEAR, c.DataNasc, GETDATE()) -
            CASE 
                WHEN MONTH(c.DataNasc) > MONTH(GETDATE())
                     OR (MONTH(c.DataNasc) = MONTH(GETDATE()) AND DAY(c.DataNasc) > DAY(GETDATE()))
                THEN 1
                ELSE 0
            END < 18
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 51002, 'A venda não pode ser feita para cliente menor de idade.', 1;
        RETURN;
    END;

    INSERT INTO Vendas (idCliente, DataVenda, ValorTotal)
    SELECT idCliente, DataVenda, ValorTotal
    FROM inserted;
END;
GO

/*=====================================VERIFICAÇÕES DO FORNECEDOR===============================*/
CREATE TRIGGER trg_Fornecedor_RestritoInativo_LimiteAbertura
ON Compras
INSTEAD OF INSERT
AS BEGIN
---------------Verifica se o fornecedor está bloqueado

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN FornecedoresRestritos r ON r.idFornecedor = i.idFornecedor
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'Fornecedor bloqueado — compra não permitida.', 1;
        RETURN;
    END;
------------------Verifica se o fornecedor está inativo

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Fornecedores f ON f.idFornecedor = i.idFornecedor
        JOIN SituacaoFornecedores s ON f.Situacao = s.id
        WHERE s.Situacao = 'I'
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50023, 'Fornecedor inativo — compra não permitida.', 1;
        RETURN;
    END;

---------------Verifica se o fornecedor tem menos de 2 anos de abertura

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Fornecedores f ON i.idFornecedor = f.idFornecedor
        WHERE DATEDIFF(YEAR, f.DataAbertura, GETDATE()) -
            CASE 
                WHEN MONTH(f.DataAbertura) > MONTH(GETDATE())
                     OR (MONTH(f.DataAbertura) = MONTH(GETDATE()) AND DAY(f.DataAbertura) > DAY(GETDATE()))
                THEN 1
                ELSE 0
            END < 2
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 51002, 'Fornecedor com menos de 2 anos de abertura — compra não permitida.', 1;
        RETURN;
    END;

    INSERT INTO Compras (idFornecedor, DataCompra, ValorTotal)
    SELECT idFornecedor, DataCompra, ValorTotal
    FROM inserted;
END;
GO

/* ================================ATUALIZAR DATA DA ULTIMA COMPRA DO CLIENTE======================= */

CREATE TRIGGER trg_AtualizaUltimaCompra		/*Rotina executada automaticamente*/
ON Vendas									/*sempre que ocorrer INSERT, UPDATE OU DELETE na tabela Vendas, a TRIGGER podera ser executada*/
AFTER INSERT								/*TRIGGER sera executada "depois" da "inserção"*/
AS BEGIN									/*Inicio do código que sera executado quando a TRIGGER for disparada*/
    UPDATE Clientes							/*Atualiza a tabela Clientes*/
    SET DataUltimaCompra = i.DataVenda		/*DataUltimaCompra será atualizado com a DataVenda vinda da tabela virtual "inserted"*/
    FROM Clientes c
    JOIN inserted i ON c.idCliente = i.idCliente; /*liga a tabela inserted com a tabela cliente, e por fim atualize apenas o cliente que fez a venda*/
END;												
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

/* ================================ATUALIZA ULTIMA VENDA DO MEDICAMENTO======================= */

CREATE OR ALTER TRIGGER trg_Atualiza_UltimaVenda_Medicamento
ON ItensVendas
AFTER INSERT
AS BEGIN
    UPDATE m
    SET m.UltimaVenda = v.DataVenda
    FROM Medicamentos m
    INNER JOIN inserted i ON m.CDB = i.CDB
    INNER JOIN Vendas v ON v.idVenda = i.idVenda;
END;
GO

/* ================================ATUALIZA ULTIMA COMPRA DO PRINCIPIO ATIVO======================= */

CREATE OR ALTER TRIGGER trg_Atualiza_UltimaCompra_Principio
ON ItensCompras
AFTER INSERT
AS BEGIN
    UPDATE p
    SET p.DataUltimaCompra = c.DataCompra
    FROM PrincipiosAtivo p
    INNER JOIN inserted i ON p.idPrincipioAt = i.idPrincipioAt
    INNER JOIN Compras c ON c.idCompra = i.idCompra;
END;
GO

/*========================================================UTILIZANDO PROCEDURES============================================================*/

/*==========CADASTRO DE CLIENTE=============*/
CREATE OR ALTER PROCEDURE sp_CadastrarCliente       /*criando a procedure assim, ela pode ser modificada, sem precisar excluir e criar dnv*/
(@Nome            VARCHAR(50),
 @CPF             CHAR(11),
 @DataNasc        DATE,
 @Situacao        INT,      
 @DataCadastro    DATE = NULL)
AS BEGIN

    IF @DataCadastro IS NULL
        SET @DataCadastro = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        --Valida se existe CPF

        IF EXISTS (SELECT 1 FROM Clientes WHERE CPF = @CPF)
        BEGIN
            THROW 60001, 'CPF já cadastrado para outro cliente.', 1;
        END;

        --Valida se a situação é valida

        IF NOT EXISTS (SELECT 1 FROM SituacaoClientes WHERE id = @Situacao)
        BEGIN
            THROW 60002, 'Situação informada não existe.', 1;
        END;

        --Inserindo o cliente

        INSERT INTO Clientes (Nome, CPF, DataNasc, DataUltimaCompra, DataCadastro, Situacao)
        VALUES (@Nome, @CPF, @DataNasc, NULL, @DataCadastro, @Situacao);

        --Recupera o ID criado
        DECLARE @NovoID INT;

        SET @NovoID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;     /*confirma o que foi feito e grava no banco*/

        /*Retorna o ID criado*/
        SELECT @NovoID AS idCliente;

    END TRY
    BEGIN CATCH     
        ROLLBACK TRANSACTION;       /*se algo deu errado, desfaz tudo*/

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Num INT = ERROR_NUMBER();

        THROW @Num, @Msg, 1;        /*mostrando o erro*/
    END CATCH
END;
GO

/*=========CADASTRO DE FORNECEDORES=============*/

CREATE OR ALTER PROCEDURE sp_CadastrarFornecedor
(@CNPJ CHAR(14),
 @RazaoSocial VARCHAR(50),
 @Pais VARCHAR(20),
 @DataAbertura DATE,
 @Situacao INT,
 @DataCadastro DATE)

AS BEGIN

    BEGIN TRY
        BEGIN TRANSACTION;

        --Valida se existe CNPJ

        IF EXISTS (SELECT 1 FROM Fornecedores WHERE CNPJ = @CNPJ)
        BEGIN
            THROW 52001, 'Já existe um fornecedor cadastrado com este CNPJ.', 1;
        END;


        --Valida se a situação é valida

        IF NOT EXISTS (SELECT 1 FROM SituacaoFornecedores WHERE id = @Situacao)
        BEGIN
            THROW 52002, 'Situação de fornecedor inválida.', 1;
        END;

  
        --Inserindo o fornecedor

        INSERT INTO Fornecedores 
            (CNPJ, RazaoSocial, Pais, DataAbertura, Situacao, UltimoFornecimento, DataCadastro)
        VALUES 
            (@CNPJ, @RazaoSocial, @Pais, @DataAbertura, @Situacao, NULL, @DataCadastro);

        DECLARE @NovoID INT;

        SET @NovoID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT @NovoID AS idFornecedor;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Num INT = ERROR_NUMBER();

        THROW @Num, @Msg, 1;
    END CATCH
END;
GO


/*======CADASTRO DE PRINCIPIOS ATIVOS=======*/

/*Ids estão sendo gerados aut. e ultima compra inicia com null e é atualizada pela trigger*/

CREATE OR ALTER PROCEDURE sp_CadastrarPrincipioAtivo
(@Nome           VARCHAR(20),
 @Situacao       INT,           
 @DataCadastro   DATE = NULL)   

AS BEGIN

    IF @DataCadastro IS NULL
        SET @DataCadastro = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        --Valida se o nome existe

        IF EXISTS (SELECT 1 FROM PrincipiosAtivo WHERE Nome = @Nome)
        BEGIN
            THROW 62001, 'Já existe um princípio ativo com esse nome.', 1;
        END;


        --Valida a situação

        IF NOT EXISTS (SELECT 1 FROM SituacaoPrincipiosAtivo WHERE id = @Situacao)
        BEGIN
            THROW 62002, 'Situação informada não existe.', 1;
        END;

  
        --Inserindo o principio ativo
  
        INSERT INTO PrincipiosAtivo (Nome, Situacao, DataUltimaCompra, DataCadastro)
        VALUES (@Nome, @Situacao, NULL, @DataCadastro);

        DECLARE @NovoID INT;

        SET @NovoID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT @NovoID AS idPrincipioAtivo;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Num INT = ERROR_NUMBER();

        THROW @Num, @Msg, 1;
    END CATCH
END;
GO


/*======CADASTRO DE MEDICAMENTO========*/

CREATE OR ALTER PROCEDURE sp_CadastrarMedicamento
(@CDB           NUMERIC(13,0),
 @ValorVenda    DECIMAL(6,2),
 @Nome          VARCHAR(40),
 @Situacao      INT,        
 @Categoria     INT,       
 @DataCadastro  DATE = NULL)

AS BEGIN

    IF @DataCadastro IS NULL
        SET @DataCadastro = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;


        --Valida se o CDB existe

        IF EXISTS (SELECT 1 FROM Medicamentos WHERE CDB = @CDB)
        BEGIN
            THROW 61001, 'Já existe um medicamento cadastrado com este CDB.', 1;
        END;


        --Valida a situação

        IF NOT EXISTS (SELECT 1 FROM SituacaoMed WHERE id = @Situacao)
        BEGIN
            THROW 61002, 'Situação informada não existe na tabela SituacaoMed.', 1;
        END;

        --Valida se a categoria existe

        IF NOT EXISTS (SELECT 1 FROM CategoriasMed WHERE id = @Categoria)
        BEGIN
            THROW 61003, 'Categoria informada não existe na tabela CategoriasMed.', 1;
        END;


        --Valida valor positivo

        IF @ValorVenda <= 0
        BEGIN
            THROW 61004, 'O valor de venda deve ser maior que zero.', 1;
        END;


        --Insere o medicamento

        INSERT INTO Medicamentos (CDB, ValorVenda, Nome, UltimaVenda, DataCadastro, Situacao, Categoria)
        VALUES (@CDB, @ValorVenda, @Nome, NULL, @DataCadastro, @Situacao, @Categoria);

        COMMIT TRANSACTION;

        SELECT @CDB AS CDB;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @Num INT = ERROR_NUMBER();

        THROW @Num, @Msg, 1;
    END CATCH;
END;
GO
