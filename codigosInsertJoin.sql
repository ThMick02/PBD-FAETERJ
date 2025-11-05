--Novos INSERT:

--Serviços:
INSERT INTO servicos (nome, valor, duracao, descricao) 
VALUES ('Limpeza de Pele Profunda', 150.00, 60, 'Extração e hidratação.');
INSERT INTO servicos (nome, valor, duracao, descricao)
VALUES ('Peeling de Diamante', 220.00, 45, 'Renovação celular da pele.');

--FilaEspera:
INSERT INTO filaespera (idCliente, idServico, dataHoraChegada, status)
VALUES (1, 2, NOW(), 0);

--AgendamentoPacote:
INSERT INTO agendamentopacote (idAgendamento, idPacote)
VALUES (4, 1);

--AgendamentoServico:
INSERT INTO agendamentoservico (idAgendamento, idServico)
VALUES (4, 1);

--PacoteServico:
INSERT INTO pacoteservico (idPacote, idServico)
VALUES (1, 3);
INSERT INTO pacoteservico (idPacote, idServico)
VALUES (1, 4);

--ProfissionalEspecialidade:
INSERT INTO profissionalespecialidade (idProfissional, idEspecialidade)
VALUES (1, 2);
INSERT INTO profissionalespecialidade (idProfissional, idEspecialidade)
VALUES (2, 1);

--ProfissionalServico:

INSERT INTO profissionalservico (idProfissional, idServico)
VALUES (1, 1);
INSERT INTO profissionalservico (idProfissional, idServico)
VALUES (1, 2);
INSERT INTO profissionalservico (idProfissional, idServico)
VALUES (2, 1);

--Comandos JOIN:

SELECT 
ag.idAgendamento,
ag.dataHoraInicio,
c.nome AS Nome_Cliente,
p.nome AS Nome_Profissional,
ag.status 
FROM 
agendamentos  AS ag 
JOIN 
clientes AS c ON ag.idCliente = c.idCliente 
LEFT JOIN 
profissionais AS p ON ag.idProfissional = p.idProfissional 
ORDER BY 
ag.dataHoraInicio;

SELECT 
p.idPagamento,
p.dataPagamento,
p.valor, c.nome AS Nome_Cliente,
ag.idAgendamento
FROM 
pagamentos AS p 
JOIN 
agendamentos AS ag ON p.idAgendamento = ag.idAgendamento 
JOIN 
clientes AS c ON ag.idCliente = c.idCliente WHERE p.status = 1;

SELECT 
a.idAgendamento,
c.nome AS Cliente,
s.nome AS Servico_Comprado,
p.nome AS Pacote_Comprado
FROM agendamentos AS a 
JOIN 
clientes AS c ON a.idCliente = c.idCliente 
LEFT JOIN 
agendamentoservico AS ags ON a.idAgendamento = ags.idAgendamento
LEFT JOIN 
servicos AS s ON ags.idServico = s.idServico 
LEFT JOIN 
agendamentopacote AS agp ON a.idAgendamento = agp.idAgendamento 
LEFT JOIN 
pacote AS p ON agp.idPacote = p.idPacote 
WHERE 
a.idAgendamento = 4;
SELECT 
p.nome AS Nome_Profissional,
s.nome AS Servico_Habilitado
FROM 
profissionais AS p 
JOIN 
profissionalservico AS ps ON p.idProfissional = ps.idProfissional
JOIN 
servicos AS s ON ps.idServico = s.idServico WHERE p.status = 1;

SELECT 
p.nome AS Nome_Pacote,
s.nome AS Servico_Incluso,
s.valor AS Valor_Avulso
FROM 
pacote AS p 
JOIN 
pacoteservico AS ps ON p.idPacote = ps.idPacote 
JOIN 
servicos AS s ON ps.idServico = s.idServico
WHERE 
p.idPacote = 1;

SELECT 
f.dataHoraChegada,
c.nome AS Nome_Cliente,
s.nome AS Servico_Desejado
FROM 
filaespera AS f
JOIN clientes AS c ON f.idCliente = c.idCliente 
JOIN
servicos AS s ON f.idServico = s.idServico 
WHERE 
f.status = 0 ORDER BY f.dataHoraChegada ASC;

SELECT 
p.nome AS Nome_Profissional,
e.nome AS Nome_Especialidade,
p.status
FROM 
profissionais AS p 
JOIN 
profissionalespecialidade AS pe ON p.idProfissional = pe.idProfissional 
JOIN 
especialidades AS e ON pe.idEspecialidade = e.idEspecialidade 
ORDER 
BY p.nome;
