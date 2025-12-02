-- FUNCIONALIDADES DO SISTEMA:

-- OBS:
-- COLOQUEI DESCRICAO EM TODAS AS FUNCIONALIDADES PARA FACILITAR COMPREENSÂSO.
-- Vou separar em blocos de funcionalidades (Cadastros, Movimentações, Atualizações e Visualiação).

-- BLOCO 1: Cadastros Básicos para preencher o Banco.

-- CADASTRANDO LOJAS (Aeroporto Galeão, Centro e Aeroporto Congonhas)
-- Nesse caso eu pesquisei 3 localizações da vida real mesmo e coloquei de exemplo pro sistema.
INSERT INTO loja (nome, Telefone, Cidade, UF, Endereco, Disponivel) VALUES 
('Aeroporto Galeão', '(21) 3398-5050', 'Rio de Janeiro', 'RJ', 'Av. Vinte de Janeiro, s/n', 1),
('Centro', '(31) 3222-5000', 'Belo Horizonte', 'MG', 'Av. Afonso Pena, 1500', 1),
('Aeroporto Congonhas', '(11) 5090-9000', 'São Paulo', 'SP', 'Av. Washington Luís, s/n', 1);

-- CADASTRANDO CLIENTES (Thiago Tavares e Silvian Giovannnis)
-- Aqui eu cadastrei um cliente pessoa e uma empresa.
INSERT INTO cliente (Nome, CPF_CNPJ, Habilitacao, Telefone) VALUES 
('Thiago Tavares', '123.456.789-00', '1234567890', '(21) 99999-1111'),
('Silvian Giovannis', '12.345.678/0001-90', '9876543210', '(11) 3030-4040');

-- CADASTRANDO FUNCIONÁRIOS (Marcio Belo, Ricardo Marciano e Claudio Bispo)
-- Aqui eu cadastrei 2 atendentes e um motorista.
INSERT INTO funcionario (Nome, CPF, Funcao) VALUES 
('Marcio Belo', '111.222.333-44', 'Atendente'),
('Ricardo Marciano', '222.333.444-55', 'Atendente'),
('Claudio Bispo', '333.444.555-66', 'Motorista');

-- CADASTRANDO MOTORISTAS (Claudio Bispo e Wagner Zanco)
-- Aqui eu cadastrei um motorista funcionário e um motorista de terceiros.
-- Como citado na criação, o motorista funcionário não recebe nome pois ele está salvo em funcionário, já o motorista de terceiros recebe o nome mas não o Id_ Funcionario.
INSERT INTO motorista (Id_Funcionario, Nome, Habilitacao) VALUES 
(3, NULL, 'CNH-ROBERTO-123'),
(NULL, 'Wagner Zanco', 'CNH-JORGE-999');

-- CADASTRANDO MODELOS DE CARRO (Argo e Corolla)
-- Adicionei dois modelos (um economico e outro mais carinho) para poder fazer alguns exemplos no futuro.
INSERT INTO modelo (Nome, Marca, Categoria) VALUES 
('Argo Drive 1.0', 'Fiat', 'Hatch'),
('Corolla XEi', 'Toyota', 'Sedan');

-- CADASTRANDO CARRO (Dois Argo e Dois Corolla)
-- Adicionei dois carros de cada modelo, dois automaticos e dois manuais e os joguei em lojas diferentes (Todos disponíveis).
INSERT INTO carro (Id_Modelo, Id_Loja_Atual, Placa, Ano_Fabricacao, Automatico, Preco, Status) VALUES 
(1, 1, 'ABC1234', '2023', 0, 120.00, 'Disponivel'),
(1, 1, 'FAT9999', '2024', 0, 130.00, 'Disponivel'),
(2, 2, 'SEX6969', '2023', 1, 250.00, 'Disponivel'),
(2, 3, 'LUX8888', '2024', 1, 280.00, 'Disponivel');

-- CADASTRANDO PLANOS DE SEGURO (Frota, Premium e Economico)
-- Os preços são baseados na minha cabeça, não pesquisei isso pois não achei necessário.
-- Plano frota é para um número maior de carros, geralmente contratado por empresas.
INSERT INTO seguro (Plano, Valor_Plano, Plano_Frota, Cobre_Furto, Cobre_Colisao, Cobre_Reserva) VALUES 
('Seguro Frota', 300.00, 1, 1, 1, 1),
('Seguro Premium', 150.00, 0, 1, 1, 1),
('Seguro Econômico', 50.00, 0, 0, 1, 0);
