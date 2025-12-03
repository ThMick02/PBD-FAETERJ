-- FUNCIONALIDADES DO SISTEMA:


-- OBS:
-- COLOQUEI DESCRICAO EM TODAS AS FUNCIONALIDADES PARA FACILITAR COMPREENSÃO.
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

-- BLOCO 2: Movimentações de Locação, Pagamento e Pacote.

-- CADASTRANDO LOCAÇÃO ÚNICA (Apenas um carro para um Cliente Pessoa)
-- A locação com o Id do Argo Drive de Placa ABC1234, para o Thiago Tavares, atendido por Marcio Belo, com seguro Premium, no Galeão, para levar agora e devolver daqui 7 dias.
-- Foi feito no Balcao e sem motorista contratado.
INSERT INTO locacao (Id_Carro, Id_Cliente, Id_Funcionario, Id_Seguro, Id_Loja_Retirada, Data_Locacao, Data_Devolucao, Periodo, Valor_Locacao, motorista, Canal) VALUES 
(1, 1, 1, 2, 1, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7, 990.00, 0, 'Balcao');
-- Criando o pagamento com o valor total e em uma única parcela.
INSERT INTO pagamento (Valor_Total, Numero_Parcelas, Status) VALUES 
(990.00, 1, 'Aprovado');
-- O pacote que faz a associativa entre o pagamento e a locação, ele é utilizado em todas os pagamentos, no entanto, ele existe para caso o Cliente faça mais de uma locação (carro).
INSERT INTO pacote (Id_Locacao, Id_Pagamento) VALUES 
(1, 1);
-- Por fim o carro assossiado a locação tem que receber um UPDATE, mudando seu Status para alugado. 
UPDATE carro SET Status = 'Alugado', Id_Loja_Atual = NULL WHERE Id = 1;

-- CADASTRANDO LOCAÇÃO ÚNICA (Frota para Cliente Empresa)
-- Primeira locação (Segue os mesmos detalhes básicos que a do cliente), sendo que seleciona o Seguro Frota e pela Internet, ou seja, nãp recebe Id de Funcionário.
INSERT INTO locacao (Id_Carro, Id_Cliente, Id_Funcionario, Id_Seguro, Id_Loja_Retirada, Data_Locacao, Data_Devolucao, Periodo, Valor_Locacao, Canal, Status) VALUES 
(3, 2, NULL, 1, 2, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY), 15, 5500.00, 'Internet', 'Em Andamento');
-- Fora isso, ambas as locações não tem motorista, pois geralmente a própria empresa teria os seus.
INSERT INTO locacao (Id_Carro, Id_Cliente, Id_Funcionario, Id_Seguro, Id_Loja_Retirada, Data_Locacao, Data_Devolucao, Periodo, Valor_Locacao, Canal, Status) VALUES 
(4, 2, NULL, 1, 3, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY), 15, 4500.00, 'Internet', 'Em Andamento');
-- O pagamento realiazndo somando o valor total e aprovando o pagamento em 3 parcelas.
INSERT INTO pagamento (Valor_Total, Numero_Parcelas, Status) VALUES 
(10000.00, 3, 'Aprovado');
-- Por fim, como dito anteriormente, o Id Pacote é responsável por associar as locações com o pagamento, ou seja, o Id das locações é alinhado com o do pagamento para adicionar o valor.
INSERT INTO pacote (Id_Locacao, Id_Pagamento) VALUES 
(2, 2),
(3, 2);
-- Novamente os carros locados recebem o status de "Alugado" e seu Id_Loja_Atual se torna nulo até que eles sejam devolvidos.
UPDATE carro SET Status = 'Alugado', Id_Loja_Atual = NULL WHERE Id IN (3, 4);

-- BLOCO 3: Atualiações do Banco de Dados.

