DROP DATABASE IF EXISTS `secomp`;
CREATE DATABASE `secomp` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `secomp`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(48) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `cidade` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `cota_patrocinio` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `curso` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `diretoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `ordem` int(11) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `evento` (
  `id` int(11) NOT NULL,
  `edicao` int(11) NOT NULL,
  `data_hora_inicio` datetime NOT NULL,
  `data_hora_fim` datetime NOT NULL,
  `inicio_inscricoes_evento` datetime NOT NULL,
  `fim_inscricoes_evento` datetime NOT NULL,
  `ano` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `instituicao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `permissao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `tipo_atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
   PRIMARY KEY (`id`)
);
CREATE TABLE `ministrante` (
  `id` int(11) NOT NULL,
  `pagar_gastos` tinyint(1) NOT NULL,
  `data_chegada_sanca` date NOT NULL,
  `data_saida_sanca` date NOT NULL,
  `precisa_acomodacao` tinyint(1) NOT NULL,
  `observacoes` varchar(512) DEFAULT NULL,
  `nome` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `telefone` varchar(64) NOT NULL,
  `profissao` varchar(64) NOT NULL,
  `empresa_univ` varchar(64) NOT NULL,
  `biografia` varchar(1024) NOT NULL,
  `foto` varchar(128) NOT NULL,
  `tamanho_cam` varchar(8) NOT NULL,
  `facebook` varchar(64) DEFAULT NULL,
  `twitter` varchar(64) DEFAULT NULL,
  `linkedin` varchar(64) DEFAULT NULL,
  `github` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `dados_hospedagem_transporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ministrante` int(11) DEFAULT NULL,
  `id_evento` int(11) DEFAULT NULL,
  `cidade_origem` varchar(64) NOT NULL,
  `data_chegada_origem` date NOT NULL,
  `data_chegada_partida` date NOT NULL,
  `transporte_ida_volta` tinyint(1) NOT NULL,
  `opcoes_transporte_ida_volta` int(11) DEFAULT NULL,
  `transporte_sanca` tinyint(1) NOT NULL,
  `opcoes_transporte_sanca` int(11) DEFAULT NULL,
  `hospedagem` tinyint(1) NOT NULL,
  `necessidades_hospedagem` varchar(256) DEFAULT NULL,
  `observacoes` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ministrante` (`id_ministrante`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_1` FOREIGN KEY (`id_ministrante`) REFERENCES `ministrante` (`id`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
);
CREATE TABLE `camiseta` (
  `id` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `tamanho` varchar(30) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `ordem_site` int(11) NOT NULL,
  `quantidade_restante` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `camiseta_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
);
CREATE TABLE `atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_evento` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `vagas_totais` int(11) DEFAULT NULL,
  `vagas_disponiveis` int(11) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL,
  `data_hora` datetime DEFAULT NULL,
  `local` varchar(64) DEFAULT NULL,
  `titulo` varchar(64) DEFAULT NULL,
  `descricao` varchar(1024) DEFAULT NULL,
  `observacoes` varchar(512) DEFAULT NULL,
  `url_codigo` varchar(255) DEFAULT NULL,
  `atividade_cadastrada` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  KEY `id_tipo` (`id_tipo`),
  CONSTRAINT `atividade_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `atividade_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_atividade` (`id`)
);
CREATE TABLE `info_feira_de_projetos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `necessidades` varchar(1024) DEFAULT NULL,
  `planejamento` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_feira_de_projetos_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
);
CREATE TABLE `info_minicurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `pre_requisitos` varchar(128) DEFAULT NULL,
  `planejamento` varchar(128) DEFAULT NULL,
  `apresentacao_extra` varchar(128) DEFAULT NULL,
  `material` varchar(128) DEFAULT NULL,
  `requisitos_ide` varchar(1024) DEFAULT NULL,
  `requisitos_bibliotecas_pacotes` varchar(1024) DEFAULT NULL,
  `requisitos_dependencias` varchar(1024) DEFAULT NULL,
  `requisitos_sistema` varchar(1024) DEFAULT NULL,
  `requisitos_observacoes` varchar(1024) DEFAULT NULL,
  `requisitos_github` varchar(1024) DEFAULT NULL,
  `requisitos_hardware` varchar(1024) DEFAULT NULL,
  `dicas_instalacao` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_minicurso_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
);
CREATE TABLE `info_palestra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `planejamento` varchar(128) DEFAULT NULL,
  `apresentacao_extra` varchar(128) DEFAULT NULL,
  `material` varchar(128) DEFAULT NULL,
  `requisitos_tecnicos` varchar(1024) DEFAULT NULL,
  `perguntas` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_palestra_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
);
CREATE TABLE `patrocinador` (
  `id` int(11) NOT NULL,
  `nome_empresa` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `ativo_site` tinyint(1) NOT NULL,
  `id_cota` int(11) NOT NULL,
  `ordem_site` int(11) NOT NULL,
  `link_website` varchar(200) DEFAULT NULL,
  `ultima_atualizacao_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`ordem_site`),
  KEY `id_cota` (`id_cota`),
  CONSTRAINT `patrocinador_ibfk_1` FOREIGN KEY (`id_cota`) REFERENCES `cota_patrocinio` (`id`)
);
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `senha` varchar(256) DEFAULT NULL,
  `primeiro_nome` varchar(64) DEFAULT NULL,
  `sobrenome` varchar(64) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `id_cidade` int(11) DEFAULT NULL,
  `id_instituicao` int(11) DEFAULT NULL,
  `token_email` varchar(90) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `autenticado` tinyint(1) DEFAULT NULL,
  `email_verificado` tinyint(1) DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `data_cadastro` datetime DEFAULT NULL,
  `salt` varchar(30) DEFAULT NULL,
  `token_alteracao_senha` varchar(90) DEFAULT NULL,
  `salt_alteracao_senha` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `id_curso` (`id_curso`),
  KEY `id_cidade` (`id_cidade`),
  KEY `id_instituicao` (`id_instituicao`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id`),
  CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicao` (`id`)
);
CREATE TABLE `participante` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `id_usuario` int(11) DEFAULT NULL,
      `id_evento` int(11) NOT NULL,
      `pacote` tinyint(1) NOT NULL,
      `id_camiseta` int(11) DEFAULT NULL,
      `data_inscricao` datetime DEFAULT NULL,
      `credenciado` tinyint(1) NOT NULL,
      `opcao_coffee` int(11) NOT NULL,
      PRIMARY KEY (`id`),
      KEY `id_usuario` (`id_usuario`),
      KEY `id_evento` (`id_evento`),
      KEY `id_camiseta` (`id_camiseta`),
      CONSTRAINT `participante_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
      CONSTRAINT `participante_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
      CONSTRAINT `participante_ibfk_3` FOREIGN KEY (`id_camiseta`) REFERENCES `camiseta` (`id`)
);
CREATE TABLE `pagamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_participante` int(11) DEFAULT NULL,
  `payment_id` varchar(200) DEFAULT NULL,
  `payer_id` varchar(200) DEFAULT NULL,
  `descricao` varchar(200) NOT NULL,
  `valor` float NOT NULL,
  `efetuado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
);
CREATE TABLE `membro_de_equipe` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `email_secomp` varchar(254) DEFAULT NULL,
  `id_cargo` int(11) NOT NULL,
  `id_diretoria` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_cargo` (`id_cargo`),
  KEY `id_diretoria` (`id_diretoria`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `membro_de_equipe_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_2` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_3` FOREIGN KEY (`id_diretoria`) REFERENCES `diretoria` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_4` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
);
CREATE TABLE `presenca` (
  `id` int(11) NOT NULL,
  `data_hora_registro` datetime NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `id_participante` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `inscrito` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_participante` (`id_participante`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `presenca_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `presenca_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  CONSTRAINT `presenca_ibfk_3` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
);
CREATE TABLE `relacao_atividade_area` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `id_atividade` int(11) DEFAULT NULL,
      `id_area` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `id_atividade` (`id_atividade`),
      KEY `id_area` (`id_area`),
      CONSTRAINT `relacao_atividade_area_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
      CONSTRAINT `relacao_atividade_area_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `area` (`id`)
);
CREATE TABLE `relacao_atividade_ministrante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_ministrante` int(11) DEFAULT NULL,
  `confirmado` tinyint(1) DEFAULT NULL,
  `admin_atividade` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_ministrante` (`id_ministrante`),
  CONSTRAINT `relacao_atividade_ministrante_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_ministrante_ibfk_2` FOREIGN KEY (`id_ministrante`) REFERENCES `ministrante` (`id`)
);
CREATE TABLE `relacao_atividade_participante` (
  `id` int(11) NOT NULL,
  `id_atividade` int(11) DEFAULT NULL,
  `id_participante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `relacao_atividade_participante_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_participante_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
);
CREATE TABLE `relacao_atividade_patrocinador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_patrocinador` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_patrocinador` (`id_patrocinador`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_2` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`)
);
CREATE TABLE `relacao_patrocinador_evento` (
  `id` int(11) NOT NULL,
  `id_patrocinador` int(11) DEFAULT NULL,
  `id_evento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_patrocinador` (`id_patrocinador`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_1` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
);
CREATE TABLE `relacao_permissao_usuario` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_permissao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_permissao` (`id_permissao`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_2` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id`)
);

INSERT INTO evento (id, edicao, data_hora_inicio, data_hora_fim, inicio_inscricoes_evento, fim_inscricoes_evento, ano) VALUES (1, 10, '2019-09-09 08:30:00', '2019-09-13 18:30:00', '2019-02-10 12:00:00', '2019-08-10 23:59:00', 2019);
INSERT INTO curso (id, nome) VALUES (1, 'Ciência da Computação');
INSERT INTO curso (id, nome) VALUES (2, 'Engenharia da Computação');
INSERT INTO instituicao (id, nome) VALUES (1, 'UFSCar');
INSERT INTO instituicao (id, nome) VALUES (2, 'USP');
INSERT INTO instituicao (id, nome) VALUES (3, 'UNESP');
INSERT INTO instituicao (id, nome) VALUES (4, 'Unicamp');
INSERT INTO cidade (id, nome) VALUES (1, 'São Carlos');
INSERT INTO cidade (id, nome) VALUES (2, 'São Paulo');
INSERT INTO cidade (id, nome) VALUES (3, 'Campinas');
INSERT INTO cidade (id, nome) VALUES (4, 'Rio Claro');
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (1, 1, 'P Feminino', 100, 1, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (2, 1, 'M Feminino', 100, 2, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (3, 1, 'G Feminino', 100, 3, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (4, 1, 'GG Feminino', 100, 4, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (5, 1, 'P Masculino', 100, 5, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (7, 1, 'M Masculino', 100, 7, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (8, 1, 'G Masculino', 100, 8, 100);
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (9, 1, 'GG Masculino', 100, 9, 100);
INSERT INTO diretoria (id, nome, ordem) VALUES (1, 'Coordenação Geral', 1);
INSERT INTO diretoria (id, nome, ordem) VALUES (2, 'TI', 2);
INSERT INTO diretoria (id, nome, ordem) VALUES (3, 'Design & Marketing', 3);
INSERT INTO diretoria (id, nome, ordem) VALUES (4, 'Conteúdo', 4);
INSERT INTO diretoria (id, nome, ordem) VALUES (5, 'Patrocínio', 5);
INSERT INTO diretoria (id, nome, ordem) VALUES (6, 'Jurídico-Financeira', 6);
INSERT INTO diretoria (id, nome, ordem) VALUES (7, 'Sociocultural', 7);
INSERT INTO cargo (id, nome) VALUES (1, 'Membro');
INSERT INTO cargo (id, nome) VALUES (2, 'Diretora');
INSERT INTO cargo (id, nome) VALUES (3, 'Diretor');
INSERT INTO cargo (id, nome) VALUES (4, 'Voluntária');
INSERT INTO cargo (id, nome) VALUES (5, 'Voluntário');
INSERT INTO cota_patrocinio (id, nome) VALUES (1, 'Diamante');
INSERT INTO cota_patrocinio (id, nome) VALUES (2, 'Ouro');
INSERT INTO cota_patrocinio (id, nome) VALUES (3, 'Prata');
INSERT INTO cota_patrocinio (id, nome) VALUES (4, 'Apoio');
INSERT INTO permissao (id, nome) VALUES (1, 'ADMIN');
INSERT INTO permissao (id, nome) VALUES (2, 'SORTEAR');
INSERT INTO permissao (id, nome) VALUES (3, 'GERAR_LISTAS');
INSERT INTO permissao (id, nome) VALUES (4, 'VENDA_PRESENCIAL');
INSERT INTO permissao (id, nome) VALUES (5, 'GERAR_CRACHAS');
INSERT INTO permissao (id, nome) VALUES (6, 'ALTERAR_CAMISETAS');
INSERT INTO permissao (id, nome) VALUES (7, 'NOTIFICACOES_APP');
INSERT INTO permissao (id, nome) VALUES (8, 'APROVAR_COMPROVANTES');

