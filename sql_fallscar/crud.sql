-- FUNCIONALIDADES DO SISTEMA:


-- OBS:
-- COLOQUEI DESCRICAO EM TODAS AS FUNCIONALIDADES PARA FACILITAR COMPREENSÃO.
-- Vou separar em blocos de funcionalidades (Cadastros, Movimentações, Atualizações e Visualiação).


-- █ █ █ █ BLOCO 1: Cadastros Básicos para preencher o Banco.

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

-- █ █ █ █ BLOCO 2: Movimentações de Locação, Pagamento e Pacote.

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

-- █ █ █ █ BLOCO 3: Atualiações do Banco de Dados.

-- DEVOLUÇÃO LOCAÇÃO ÚNICA (Carro do Thiago Cliente Pessoa)
-- Update que adiciona a loja que o carro foi devolvido e a data de devolução - Atribuindo o Status de Concluído a locação.
UPDATE locacao 
SET Id_Loja_Devolucao = 1, Data_Devolucao = NOW(), Status = 'Concluido' 
WHERE Id = 1;
-- Update do carro que foi locado, voltando a estar disponível e atualizando sua localização.
UPDATE carro 
SET Status = 'Disponivel', Id_Loja_Atual = 1 
WHERE Id = 1;

-- DEVOLUÇÃO FROTA (Carros de Silvian Cliente Empresa)
-- Update novamente atribui a data e loja de devolução (Ambas na loja do centro) e concluindo ambas as locações.
UPDATE locacao 
SET Id_Loja_Devolucao = 3, Data_Devolucao = NOW(), Status = 'Concluido' 
WHERE Id IN (2, 3);
-- Juntamente, os carros recebem o status e a loja atual, igual ao do cliente único, fé.
UPDATE carro 
SET Status = 'Disponivel', Id_Loja_Atual = 3 
WHERE Id IN (3, 4);

-- ACIDENTE NO TRABALHO - CARRO DEVE SER ENVIADO A MANUTENÇÃO
-- Carro é rastreado por sua placa e seu status é atribuído para "Manutenção."
-- Além disso, seu Id_Loja_Atual é retirado para identificar que ele não se encontra em nenhuma loja atualmente.
UPDATE carro
SET Status = 'Manutencao', Id_Loja_Atual = NULL
WHERE Placa = 'FAT9999';
-- Depois de alguns dias, o carro sai da manutenção e é devolvido para a loja de origem.
UPDATE carro
SET Status = 'Disponível', Id_Loja_Atual = 3
WHERE Placa = 'FAT9999';

-- POR MOTIVOS DE INFLAÇÃO O FINANCEIRO DECIDIU AUMENTAR O VALOR DOS SEGUROS.
-- Update simples que aumenta o valor em 10%.
UPDATE seguro
SET Valor_Plano = Valor_Plano * 1.10;

-- CARRO FOI FURTADO - DELETANDO DO SISTEMA E REALOCANDO.
-- Para que possa excluir o carro, primeiro desabilito o CHECK de Keys Estrangeiras temporariamente.
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM carro WHERE Placa = 'ABC1234';
SET FOREIGN_KEY_CHECKS = 1;
-- Após deletar o carro roubado, eu vou e crio um novo carro de mesmo modelo mas com uma nova placa.
-- O preço é similar e características são similares ao carro perdido.
INSERT INTO carro (Id_Modelo, Id_Loja_Atual, Placa, Ano_Fabricacao, Automatico, Preco, Status) VALUES 
(1, 1, 'XYZ6789', '2025', 0, 125.00, 'Disponivel');

-- EMPRESA DECIDIU ALTERAR SEU TELEFONE ADMNISTRATIVO, ALTERAR CADASTRO PARA CONTATO.
-- Update simples, o número de telefone da Empresa Silvian é alterado.
UPDATE cliente 
SET Telefone = '(11) 97777-1234' 
WHERE Id = 2;

-- POR CAUSA DE CHUVAS FORTES E ESTRUTURA DE ESCOAMENTO RUIM DA REGIÃO, O LOJA DO AEROPORTO GALEÃO ESTÁ EM OBAS.
-- Com a loja em obras, todos os carros presentes nela foram enviados para a unidade mais próxima.
-- Assim todos os carros no Galeão são transferidos para o Aeroporto Congonhas.
UPDATE carro 
SET Id_Loja_Atual = 3 
WHERE Id_Loja_Atual = 1;
-- O marcador booleano de disponibilidade do Galeão é alterado pra falso.
UPDATE loja SET Disponivel = 0 WHERE Id = 1;

-- DEPOIS DE ANOS DE TRABALHO O ATENDENTE RICARDO MARCIANO SE APOSENTOU.
-- Primeiro o deletamos do sistema e depois iremos adicionar um novo funcionário para a vaga.
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM funcionario WHERE Nome = 'Ricardo Marciano';
SET FOREIGN_KEY_CHECKS = 1;
-- O novo funcionário é adicionado, Paulo Galhanone.
INSERT INTO funcionario (Nome, CPF, Funcao) VALUES 
('Paulo Galhanone', '555.666.777-88', 'Atendente');

-- █ █ █ █ BLOCO 4: Visualização das Tabelas.

-- VISUALIZAÇÃO DA FROTA.
-- Usei o Select normalmente e depois utiliei o Join para interligar os Id.s, mostrando assim o Nome do Modelo no Modelo Id e a Localiação Atual.
-- Alternativamente, dizendo que um carro possa estar fora da loja caso ele esteja em manutenção ou alugado.
SELECT 
    c.Placa, 
    m.Nome AS Modelo, 
    m.Categoria, 
    c.Ano_Fabricacao, 
    c.Status,
    IFNULL(l.nome, '--- Fora da Loja ---') AS Localizacao_Atual
FROM carro c
INNER JOIN modelo m ON c.Id_Modelo = m.Id
LEFT JOIN loja l ON c.Id_Loja_Atual = l.Id
ORDER BY c.Status, m.Nome;

-- VISUALIZAÇÃO DE FUNCIONÁRIOS E MOTORISTAS.
-- Aqui é simples, tem um CASE que verifica se o Funcionário possui habilitação e mostra a função.
-- Fora isso ele mostra tanto os funcionários quanto os não funcionários, os separando entre Motorista, Atendente ou Terceiro. (Usando o UNION ALL para interligar os SELECT)
SELECT 
    f.Nome AS Funcionario,
    f.Funcao,
    m.Habilitacao AS CNH_Motorista,
    CASE 
        WHEN m.Id IS NOT NULL THEN 'Sim' 
        ELSE 'Não' 
    END AS Habilitado_Dirigir
FROM funcionario f
LEFT JOIN motorista m ON m.Id_Funcionario = f.Id
UNION ALL
SELECT 
    m.Nome AS Funcionario,
    'Terceiro' AS Funcao,
    m.Habilitacao,
    'Sim'
FROM motorista m
WHERE m.Id_Funcionario IS NULL;

-- VISUALIZAÇÃO DO HISTÓRICO DE LOCAÇÕES.
-- Aqui ele mostra o histórico de locações, mostrando nome do cliente, modelo do carro, placa, status da locação.
-- A parte mais dificil que eu tive que pesquisar um pouco para saber como colocar, foi mostrar as datas previstas ou de devolução.
-- Pra isso eu criei um CASE que quando o Status estiver como Concluído, usará a data Devolução do dia, do contrário, não foi ainda e tem apenas a data prevista.
SELECT 
    cli.Nome AS Cliente,
    m.Nome AS Carro,
    c.Placa,
    loc.Status AS Situacao,
    loc.Data_Locacao AS Data_Inicio,
    CASE 
        WHEN loc.Status = 'Concluido' THEN loc.Data_Devolucao
        ELSE DATE_ADD(loc.Data_Locacao, INTERVAL loc.Periodo DAY)
    END AS Data_Devolução
FROM locacao loc
INNER JOIN cliente cli ON loc.Id_Cliente = cli.Id
INNER JOIN carro c ON loc.Id_Carro = c.Id
INNER JOIN modelo m ON c.Id_Modelo = m.Id
ORDER BY loc.Data_Locacao DESC;

-- GERAÇÃO DE RELATÓRIO FINANCEIRO.
-- Para registro de pagamentos, com o intuito de calculos de lucro, sendo essas todas as informações presentes na tabela de pagamento.
SELECT 
    p.Id AS Cod_Pagamento,
    p.Data_Pagamento,
    p.Valor_Total,
    p.Numero_Parcelas,
    p.Status
FROM pagamento p
ORDER BY p.Data_Pagamento DESC;

-- HISTÓRICO DOS CARROS POR MODELO.
-- Aqui é simples, usa o Select com o Hoin para interligar informações da Locação com as informações do carro e gerar o histórico com base no Id do modelo.
SELECT 
    c.Placa,
    cli.Nome AS Cliente_Locatario,
    l_ret.nome AS Retirado_Em,
    loc.Data_Locacao,
    l_dev.nome AS Devolvido_Em,
    loc.Data_Devolucao
FROM locacao loc
INNER JOIN carro c ON loc.Id_Carro = c.Id
INNER JOIN cliente cli ON loc.Id_Cliente = cli.Id
INNER JOIN loja l_ret ON loc.Id_Loja_Retirada = l_ret.Id
LEFT JOIN loja l_dev ON loc.Id_Loja_Devolucao = l_dev.Id
WHERE c.Id_Modelo = 2;
