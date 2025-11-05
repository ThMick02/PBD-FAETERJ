--Clientes:

INSERT INTO clientes (nome, email, telefone, cpf, senhaHash, dataCadastro) 
VALUES ('Thiago Tavares', 'thiago@email.com', '21999998888', '11122233344', 'hash_senha_abc123', NOW());
INSERT INTO clientes (nome, email, telefone, cpf, senhaHash, dataCadastro) 
VALUES ('Ana Souza', 'ana.souza@email.com', '21888887777', '55566677788', 'hash_senha_xyz456', NOW());

UPDATE clientes 
SET telefone = '21987654321' 
WHERE idCliente = 1;

DELETE FROM clientes WHERE idCliente = 2;

--Profissionais:

INSERT INTO profissionais (nome, telefone, status) 
VALUES ('Beatriz Costa', '21777776666', 1);
INSERT INTO profissionais (nome, telefone, status) 
VALUES ('Lucas Martins', '21666665555', 1);

UPDATE profissionais 
SET status = 0 
WHERE idProfissional = 2;

--Agendamentos:

INSERT INTO agendamentos (idCliente, idProfissional, dataHoraInicio, dataHoraFim, status, origemReserva) 
VALUES (1, 1, '2025-11-20 10:00:00', '2025-11-20 11:00:00', 0, 1);
INSERT INTO agendamentos (idCliente, idProfissional, dataHoraInicio, dataHoraFim, status, origemReserva) 
VALUES (2, 2, '2025-11-21 14:00:00', '2025-11-21 15:30:00', 0, 1);
INSERT INTO agendamentos (idCliente, idProfissional, dataHoraInicio, dataHoraFim, status, origemReserva) 
VALUES (1, NULL, '2025-11-22 16:00:00', '2025-11-22 17:00:00', 0, 1);

UPDATE agendamentos 
SET status = 1 
WHERE idAgendamento = 4;

SELECT idAgendamento, idCliente, idProfissional FROM agendamentos;

DELETE FROM agendamentos WHERE idAgendamento = 5;

--Serviços:

INSERT INTO servicos (nome, valor, duracao, descricao) 
VALUES ('Massagem Relaxante', 180.00, 60, 'Massagem com óleos essenciais para alívio de estresse.');
INSERT INTO servicos (nome, valor, duracao, descricao) 
VALUES ('Manicure e Pedicure', 75.00, 90, 'Tratamento completo de unhas, cutículas e esmaltação.');

UPDATE servicos SET valor = 195.00 WHERE idServico = 1;

--Especialidades:

INSERT INTO especialidades (nome, descricao) 
VALUES ('Estética Corporal', 'Tratamentos focados na redução de medidas e celulite.');
INSERT INTO especialidades (nome, descricao) 
VALUES ('Cabelo e Penteado', 'Cortes, coloração e tratamentos capilares.');

UPDATE especialidades
SET nome = 'Cabelo e Coloração' 
WHERE idEspecialidade = 2;

SELECT * FROM especialidades;

--Pacote:

INSERT INTO pacote (nome, precoPacote, descricao) 
VALUES ('Tratamento Facial Completo', 450.00, 'Limpeza de pele profunda + Hidratação + Máscara de LED');

UPDATE pacote 
SET precoPacote = 475.00 
WHERE idPacote = 1;

--Pagamentos:

INSERT INTO pagamentos (idAgendamento, transacaoGateway, valor, dataPagamento, status) 
VALUES (4, 'ch_5B3sDyLkdSb42fXq1ZkXn2Yk', 180.00, '2025-11-20 10:05:00', 1);
INSERT INTO pagamentos (idAgendamento, transacaoGateway, valor, dataPagamento, status) 
VALUES (5, 'ch_6C4tEzLkdSb42fXq1ZkXn3Zl', 75.00, '2025-11-21 14:02:00', 1);

DELETE FROM pagamentos WHERE idAgendamento = 5;

SELECT * FROM pagamentos;
