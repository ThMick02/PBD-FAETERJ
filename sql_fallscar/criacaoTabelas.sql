--OBS:
-- COLOQUEI DESCRIÇÃO EM TODAS AS TABELAS PARA FACILITAR A VISUALIAZÇÃO DE SEUS OBJETIVOS.
-- Como a apresentação da semana passada não foi entregue o desejado, simulei uma pelos comentários para passar minhas ideias.

-- TABELA CLIENTE:
-- Aqui o cliente será cadastrado com suas informações essenciais pro sistema: 
-- Nome, CPF ou CNPJ (Caso seja uma empresa), Habilitação (Podendo ser tanto a do cliente quanto a de um terceiro) e Telefone para o contato para casos de atrasos, etc...

CREATE TABLE cliente (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Nome varchar(100) NOT NULL,
  CPF_CNPJ varchar(18) NOT NULL UNIQUE,
  Habilitacao varchar(20) NOT NULL,
  Telefone varchar(20) NOT NULL
);

-- TABELA LOJA:
-- Na tabela da Loja eu decidi colocar: 
-- Localização (Endereço, municipio e estado), o telefone para o locar por ligação, nome ("Aeroporto Galeão") e um booleano para verificar sua disponibilidade.

CREATE TABLE loja (
  Id int PRIMARY KEY AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  Telefone varchar(20) DEFAULT NULL,
  Cidade varchar(30) NOT NULL,
  UF char(2) NOT NULL,
  Endereco varchar(100) DEFAULT NULL,
  Disponivel tinyint(1) DEFAULT 1
);

-- TABELA MODELO:
-- O modelo é basicamente uma tabela genérica para a tabela "Carro", ele é utilizado como base para informações que não são únicas de apenas um carro.
-- Nome (HB20, Corolla, etc), Marca (Fiat) e Categoria (Hatch, SUV, etc).

CREATE TABLE modelo (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Nome varchar(100) NOT NULL,
  Marca varchar(20) NOT NULL,
  Categoria varchar(15) NOT NULL
);

-- TABELA CARRO:
-- O carro é a forma especifica do modelo, ele carrega suas especificações e carrega informações únicas daquela carro:
-- Placa (Usa o UNIQUE pois não pode permitir iguais), Ano de Fabricação, Booleano que identifica se é Automatico ou não, o Preço (depende de fatores além do modelo, tipo o ano).
-- o Status de disponibilidade e duas chaves secundárias, sendo elas a loja que ele se encontra (Não é NOT NULL pois ele pode estar alugado) e seu modelo.

CREATE TABLE carro (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Id_Modelo int NOT NULL,
  Id_Loja_Atual int,
  Placa char(7) NOT NULL UNIQUE,
  Ano_Fabricacao char(4) DEFAULT NULL,
  Automatico tinyint(1) DEFAULT 0,
  Preco decimal(10,2) NOT NULL,
  Status varchar(15) DEFAULT 'Disponivel',
  
  FOREIGN KEY (Id_Modelo) REFERENCES modelo (Id),
  FOREIGN KEY (Id_Loja_Atual) REFERENCES loja (Id)
);

-- TABELA FUNCIONÁRIO:
-- Funcionario é e não é uma tabela genérica de motorista, pois o motorista pode ou não ser um funcionário.
-- Sendo assim botei informações básicas: Nome, CPF unico e a Funcao (Atendente e Motorista).

CREATE TABLE funcionario (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Nome varchar(100) NOT NULL,
  CPF varchar(11) NOT NULL UNIQUE,
  Funcao varchar(10) NOT NULL
);

-- TABELA MOTORISTA:
-- Como dito acima, ele pode ou não ser um funcionário, sendo assim o Id_Funcionario e Nome são informações opcionais (Para evitar duplicar a informação do nome caso seja funcionário).
-- Por fim o óbvio que é a habilitação.

CREATE TABLE motorista (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Id_Funcionario int,
  Nome varchar(100),
  Habilitacao varchar(20) NOT NULL,

  FOREIGN KEY (Id_Funcionario) REFERENCES Funcionario (Id)
);

-- TABELA SEGURO:
-- O seguro é uma opcional da locação, ele tem o nome do Plano (Completo, Premium, Economico, etc...), seu valor e vários booleanos do que o plano irá cobrir.

CREATE TABLE seguro (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Plano varchar(50) NOT NULL,
  Valor_Plano decimal(10,2) NOT NULL,
  Plano_Frota tinyint(1) DEFAULT 0,
  Cobre_Furto tinyint(1) DEFAULT 0,
  Cobre_Colisao tinyint(1) DEFAULT 0,
  Cobre_Reserva tinyint(1) DEFAULT 0
);

-- TABELA LOCAÇÃO:
-- Locação é a tabela central, ela se liga a diversas tabelas e é a funcionalidade principal do sistema.
-- É importante observar que existem coisas que em sua base são DEFAULT NULL pois não são obrigatórias (Funcionario pode ser pelo site, Seguro, Motorista)
-- Loja Devolucao é Null e depois recebe o UPDATE quando o carro for devolvido, periodo tem um CHECK para limitar as opções e o canal apenas guarda o meio da locacao (site, telefone, etc)
-- Tem o booleano do motorista para checar se foi solicitado e o valor da locacao para somar no pacote no final.

CREATE TABLE locacao (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Id_Carro int NOT NULL,
  Id_Cliente int NOT NULL,
  Id_Funcionario int DEFAULT NULL,
  Id_Seguro int DEFAULT NULL,
  Id_Motorista int DEFAULT NULL,
  Id_Loja_Retirada int NOT NULL,
  Id_Loja_Devolucao int DEFAULT NULL,
  Data_Locacao datetime NOT NULL,
  Data_Devolucao datetime NOT NULL,
  Periodo int NOT NULL,
  Valor_Locacao decimal(10,2) NOT NULL,
  motorista tinyint(1) DEFAULT 0,
  Canal varchar(15) NOT NULL,
  Status varchar(20) DEFAULT 'Em Andamento',
  
  FOREIGN KEY (Id_Carro) REFERENCES carro (Id),
  FOREIGN KEY (Id_Cliente) REFERENCES cliente (Id),
  FOREIGN KEY (Id_Funcionario) REFERENCES funcionario (Id),
  FOREIGN KEY (Id_Seguro) REFERENCES seguro (Id),
  FOREIGN KEY (Id_Motorista) REFERENCES motorista (Id),
  FOREIGN KEY (Id_Loja_Retirada) REFERENCES loja (Id),
  FOREIGN KEY (Id_Loja_Devolucao) REFERENCES loja (Id),

  CHECK (Periodo IN (7, 15, 30))
);

-- TABELA PAGAMENTO:
-- A tabela pagamento é bem simples, ela não recebe chaves estrangeiras por causa da próximas tabela.
-- Guarda a data (utiliza o horário que é cadastrado o INSERT), o status (que é mantido como pendente até ser pago), o numero de parcelas e o valor total que é a soma das locacoes.

CREATE TABLE pagamento (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Valor_Total decimal(10,2) NOT NULL,
  Numero_Parcelas tinyint(2) DEFAULT 1,
  Data_Pagamento datetime DEFAULT current_timestamp(),
  Status varchar(15) DEFAULT 'Pendente'
);

-- TABELA PACOTE:
-- A tabela pacote é uma tabela associativa entre locacao e pagamento.
-- Da forma que eu imaginei, cada carro alugado gera uma locação e no fim o cliente junta todas as locações que ele deseja em um pacote para assim efetuar o pagamento.
-- Pensei assim para casos de familias grandes que aluguem mais de um carro (Não ter que pagar duas vezes) e no caso de empresas que aluguem uma maior quantidade de carros.

CREATE TABLE pacote (
  Id int PRIMARY KEY AUTO_INCREMENT,
  Id_Locacao int NOT NULL,
  Id_Pagamento int NOT NULL,
  
  FOREIGN KEY (Id_Locacao) REFERENCES locacao (Id),
  FOREIGN KEY (Id_Pagamento) REFERENCES pagamento (Id)
);
