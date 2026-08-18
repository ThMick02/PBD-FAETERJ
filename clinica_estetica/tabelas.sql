-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/11/2025 às 20:23
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `clinica_estetica`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentopacote`
--

CREATE TABLE `agendamentopacote` (
  `idAgendamentoPacote` int(11) NOT NULL,
  `idAgendamento` int(11) NOT NULL,
  `idPacote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentopacote`
--

INSERT INTO `agendamentopacote` (`idAgendamentoPacote`, `idAgendamento`, `idPacote`) VALUES
(1, 4, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `idAgendamento` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `dataHoraInicio` datetime NOT NULL,
  `dataHoraFim` datetime NOT NULL,
  `status` int(11) DEFAULT NULL,
  `origemReserva` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`idAgendamento`, `idCliente`, `idProfissional`, `dataHoraInicio`, `dataHoraFim`, `status`, `origemReserva`) VALUES
(4, 1, 1, '2025-11-20 10:00:00', '2025-11-20 11:00:00', 1, 1),
(6, 1, NULL, '2025-11-22 16:00:00', '2025-11-22 17:00:00', 0, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentoservico`
--

CREATE TABLE `agendamentoservico` (
  `idServicoAgendamentos` int(11) NOT NULL,
  `idAgendamento` int(11) NOT NULL,
  `idServico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentoservico`
--

INSERT INTO `agendamentoservico` (`idServicoAgendamentos`, `idAgendamento`, `idServico`) VALUES
(1, 4, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `senhaHash` varchar(255) NOT NULL,
  `credito` decimal(10,2) DEFAULT 0.00,
  `dataCadastro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nome`, `email`, `telefone`, `cpf`, `senhaHash`, `credito`, `dataCadastro`) VALUES
(1, 'Thiago Tavares', 'thiago@email.com', '21987654321', '11122233344', 'hash_senha_abc123', 0.00, '2025-11-05 15:24:14');

-- --------------------------------------------------------

--
-- Estrutura para tabela `especialidades`
--

CREATE TABLE `especialidades` (
  `idEspecialidade` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `especialidades`
--

INSERT INTO `especialidades` (`idEspecialidade`, `nome`, `descricao`) VALUES
(1, 'Estética Corporal', 'Tratamentos focados na redução de medidas e celulite.'),
(2, 'Cabelo e Coloração', 'Cortes, coloração e tratamentos capilares.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `filaespera`
--

CREATE TABLE `filaespera` (
  `idFila` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idServico` int(11) NOT NULL,
  `dataHoraChegada` datetime NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `filaespera`
--

INSERT INTO `filaespera` (`idFila`, `idCliente`, `idServico`, `dataHoraChegada`, `status`) VALUES
(1, 1, 2, '2025-11-05 16:05:19', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentocredito`
--

CREATE TABLE `movimentocredito` (
  `idCreditoCliente` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `entradaSaida` tinyint(1) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `dataMovimento` datetime NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pacote`
--

CREATE TABLE `pacote` (
  `idPacote` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `precoPacote` decimal(10,2) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pacote`
--

INSERT INTO `pacote` (`idPacote`, `nome`, `precoPacote`, `descricao`) VALUES
(1, 'Tratamento Facial Completo', 475.00, 'Limpeza de pele profunda + Hidratação + Máscara de LED');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pacoteservico`
--

CREATE TABLE `pacoteservico` (
  `idPacoteServico` int(11) NOT NULL,
  `idPacote` int(11) NOT NULL,
  `idServico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pacoteservico`
--

INSERT INTO `pacoteservico` (`idPacoteServico`, `idPacote`, `idServico`) VALUES
(1, 1, 3),
(2, 1, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `idPagamento` int(11) NOT NULL,
  `idAgendamento` int(11) NOT NULL,
  `transacaoGateway` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `dataPagamento` datetime NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pagamentos`
--

INSERT INTO `pagamentos` (`idPagamento`, `idAgendamento`, `transacaoGateway`, `valor`, `dataPagamento`, `status`) VALUES
(3, 4, 'ch_5B3sDyLkdSb42fXq1ZkXn2Yk', 180.00, '2025-11-20 10:05:00', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `profissionais`
--

CREATE TABLE `profissionais` (
  `idProfissional` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissionais`
--

INSERT INTO `profissionais` (`idProfissional`, `nome`, `telefone`, `status`) VALUES
(1, 'Beatriz Costa', '21777776666', 1),
(2, 'Lucas Martins', '21666665555', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `profissionalespecialidade`
--

CREATE TABLE `profissionalespecialidade` (
  `idProfissionalEspecialidade` int(11) NOT NULL,
  `idProfissional` int(11) NOT NULL,
  `idEspecialidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissionalespecialidade`
--

INSERT INTO `profissionalespecialidade` (`idProfissionalEspecialidade`, `idProfissional`, `idEspecialidade`) VALUES
(1, 1, 2),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `profissionalservico`
--

CREATE TABLE `profissionalservico` (
  `idProfissionalServico` int(11) NOT NULL,
  `idProfissional` int(11) NOT NULL,
  `idServico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissionalservico`
--

INSERT INTO `profissionalservico` (`idProfissionalServico`, `idProfissional`, `idServico`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 1, 1),
(5, 1, 2),
(6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `idServico` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `duracao` int(11) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`idServico`, `nome`, `valor`, `duracao`, `descricao`) VALUES
(1, 'Massagem Relaxante', 195.00, 60, 'Massagem com óleos essenciais para alívio de estresse.'),
(2, 'Manicure e Pedicure', 75.00, 90, 'Tratamento completo de unhas, cutículas e esmaltação.'),
(3, 'Limpeza de Pele Profunda', 150.00, 60, 'Extração e hidratação.'),
(4, 'Peeling de Diamante', 220.00, 45, 'Renovação celular da pele.');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentopacote`
--
ALTER TABLE `agendamentopacote`
  ADD PRIMARY KEY (`idAgendamentoPacote`),
  ADD KEY `idAgendamento` (`idAgendamento`),
  ADD KEY `idPacote` (`idPacote`);

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`idAgendamento`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idProfissional` (`idProfissional`);

--
-- Índices de tabela `agendamentoservico`
--
ALTER TABLE `agendamentoservico`
  ADD PRIMARY KEY (`idServicoAgendamentos`),
  ADD KEY `idAgendamento` (`idAgendamento`),
  ADD KEY `idServico` (`idServico`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices de tabela `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`idEspecialidade`);

--
-- Índices de tabela `filaespera`
--
ALTER TABLE `filaespera`
  ADD PRIMARY KEY (`idFila`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idServico` (`idServico`);

--
-- Índices de tabela `movimentocredito`
--
ALTER TABLE `movimentocredito`
  ADD PRIMARY KEY (`idCreditoCliente`),
  ADD KEY `idCliente` (`idCliente`);

--
-- Índices de tabela `pacote`
--
ALTER TABLE `pacote`
  ADD PRIMARY KEY (`idPacote`);

--
-- Índices de tabela `pacoteservico`
--
ALTER TABLE `pacoteservico`
  ADD PRIMARY KEY (`idPacoteServico`),
  ADD KEY `idPacote` (`idPacote`),
  ADD KEY `idServico` (`idServico`);

--
-- Índices de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`idPagamento`),
  ADD KEY `idAgendamento` (`idAgendamento`);

--
-- Índices de tabela `profissionais`
--
ALTER TABLE `profissionais`
  ADD PRIMARY KEY (`idProfissional`);

--
-- Índices de tabela `profissionalespecialidade`
--
ALTER TABLE `profissionalespecialidade`
  ADD PRIMARY KEY (`idProfissionalEspecialidade`),
  ADD KEY `idProfissional` (`idProfissional`),
  ADD KEY `idEspecialidade` (`idEspecialidade`);

--
-- Índices de tabela `profissionalservico`
--
ALTER TABLE `profissionalservico`
  ADD PRIMARY KEY (`idProfissionalServico`),
  ADD KEY `idProfissional` (`idProfissional`),
  ADD KEY `idServico` (`idServico`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`idServico`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentopacote`
--
ALTER TABLE `agendamentopacote`
  MODIFY `idAgendamentoPacote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `idAgendamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `agendamentoservico`
--
ALTER TABLE `agendamentoservico`
  MODIFY `idServicoAgendamentos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `idEspecialidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `filaespera`
--
ALTER TABLE `filaespera`
  MODIFY `idFila` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `movimentocredito`
--
ALTER TABLE `movimentocredito`
  MODIFY `idCreditoCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pacote`
--
ALTER TABLE `pacote`
  MODIFY `idPacote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pacoteservico`
--
ALTER TABLE `pacoteservico`
  MODIFY `idPacoteServico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `idPagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `profissionais`
--
ALTER TABLE `profissionais`
  MODIFY `idProfissional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `profissionalespecialidade`
--
ALTER TABLE `profissionalespecialidade`
  MODIFY `idProfissionalEspecialidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `profissionalservico`
--
ALTER TABLE `profissionalservico`
  MODIFY `idProfissionalServico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `idServico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentopacote`
--
ALTER TABLE `agendamentopacote`
  ADD CONSTRAINT `agendamentopacote_ibfk_1` FOREIGN KEY (`idAgendamento`) REFERENCES `agendamentos` (`idAgendamento`),
  ADD CONSTRAINT `agendamentopacote_ibfk_2` FOREIGN KEY (`idPacote`) REFERENCES `pacote` (`idPacote`);

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamentos_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  ADD CONSTRAINT `agendamentos_ibfk_2` FOREIGN KEY (`idProfissional`) REFERENCES `profissionais` (`idProfissional`);

--
-- Restrições para tabelas `agendamentoservico`
--
ALTER TABLE `agendamentoservico`
  ADD CONSTRAINT `agendamentoservico_ibfk_1` FOREIGN KEY (`idAgendamento`) REFERENCES `agendamentos` (`idAgendamento`),
  ADD CONSTRAINT `agendamentoservico_ibfk_2` FOREIGN KEY (`idServico`) REFERENCES `servicos` (`idServico`);

--
-- Restrições para tabelas `filaespera`
--
ALTER TABLE `filaespera`
  ADD CONSTRAINT `filaespera_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  ADD CONSTRAINT `filaespera_ibfk_2` FOREIGN KEY (`idServico`) REFERENCES `servicos` (`idServico`);

--
-- Restrições para tabelas `movimentocredito`
--
ALTER TABLE `movimentocredito`
  ADD CONSTRAINT `movimentocredito_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`);

--
-- Restrições para tabelas `pacoteservico`
--
ALTER TABLE `pacoteservico`
  ADD CONSTRAINT `pacoteservico_ibfk_1` FOREIGN KEY (`idPacote`) REFERENCES `pacote` (`idPacote`),
  ADD CONSTRAINT `pacoteservico_ibfk_2` FOREIGN KEY (`idServico`) REFERENCES `servicos` (`idServico`);

--
-- Restrições para tabelas `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`idAgendamento`) REFERENCES `agendamentos` (`idAgendamento`);

--
-- Restrições para tabelas `profissionalespecialidade`
--
ALTER TABLE `profissionalespecialidade`
  ADD CONSTRAINT `profissionalespecialidade_ibfk_1` FOREIGN KEY (`idProfissional`) REFERENCES `profissionais` (`idProfissional`),
  ADD CONSTRAINT `profissionalespecialidade_ibfk_2` FOREIGN KEY (`idEspecialidade`) REFERENCES `especialidades` (`idEspecialidade`);

--
-- Restrições para tabelas `profissionalservico`
--
ALTER TABLE `profissionalservico`
  ADD CONSTRAINT `profissionalservico_ibfk_1` FOREIGN KEY (`idProfissional`) REFERENCES `profissionais` (`idProfissional`),
  ADD CONSTRAINT `profissionalservico_ibfk_2` FOREIGN KEY (`idServico`) REFERENCES `servicos` (`idServico`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
