DROP DATABASE IF EXISTS `secomp`;
CREATE DATABASE `secomp` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `secomp`;

CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(48) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `cidade` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `cota_patrocinio` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `curso` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `tipo_atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `permissao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `diretoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordem` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `instituicao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `urlconteudo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `codigo` varchar(200) NOT NULL,
  `ultimo_gerado` tinyint(1) NOT NULL,
  `valido` tinyint(1) NOT NULL,
  `numero_cadastros` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `evento` (
  `id` int(11) NOT NULL,
  `edicao` int(11) NOT NULL,
  `data_hora_inicio` datetime NOT NULL,
  `data_hora_fim` datetime NOT NULL,
  `inicio_inscricoes_evento` datetime NOT NULL,
  `fim_inscricoes_evento` datetime NOT NULL,
  `abertura_minicursos_1_etapa` datetime NOT NULL,
  `abertura_minicursos_2_etapa` datetime NOT NULL,
  `fechamento_minicursos_1_etapa` datetime NOT NULL,
  `fechamento_minicursos_2_etapa` datetime NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `preco_kit` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `flag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) NOT NULL,
  `pontos` int(11) NOT NULL,
  `ativa` tinyint(1) DEFAULT NULL,
  `quantidade_utilizada` int(11) DEFAULT NULL,
  `evento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `evento_id` (`evento_id`),
  CONSTRAINT `flag_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_evento` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `vagas_totais` int(11) DEFAULT NULL,
  `vagas_disponiveis` int(11) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL,
  `data_hora_inicio` datetime DEFAULT NULL,
  `data_hora_fim` datetime DEFAULT NULL,
  `local` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_codigo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atividade_cadastrada` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  KEY `id_tipo` (`id_tipo`),
  CONSTRAINT `atividade_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `atividade_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `camiseta` (
  `id` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `tamanho` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantidade` int(11) NOT NULL,
  `ordem_site` int(11) NOT NULL,
  `quantidade_restante` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `camiseta_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `senha` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primeiro_nome` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sobrenome` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `id_cidade` int(11) DEFAULT NULL,
  `id_instituicao` int(11) DEFAULT NULL,
  `token_email` varchar(90) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `autenticado` tinyint(1) DEFAULT NULL,
  `email_verificado` tinyint(1) DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `data_cadastro` datetime DEFAULT NULL,
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_alteracao_senha` varchar(90) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt_alteracao_senha` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `id_curso` (`id_curso`),
  KEY `id_cidade` (`id_cidade`),
  KEY `id_instituicao` (`id_instituicao`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id`),
  CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `participante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_evento` int(11) NOT NULL,
  `data_inscricao` datetime DEFAULT NULL,
  `credenciado` tinyint(1) NOT NULL,
  `opcao_coffee` int(11) NOT NULL,
  `pontuacao` int(11) DEFAULT NULL,
  `minicurso_etapa_1` int(11) DEFAULT NULL,
  `minicurso_etapa_2` int(11) DEFAULT NULL,
  `uuid` varchar(512) DEFAULT NULL,  
  `wifi` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_evento` (`id_evento`),
  KEY `minicurso_etapa_1` (`minicurso_etapa_1`),
  KEY `minicurso_etapa_2` (`minicurso_etapa_2`),
  CONSTRAINT `participante_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `participante_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `participante_ibfk_3` FOREIGN KEY (`minicurso_etapa_1`) REFERENCES `atividade` (`id`),
  CONSTRAINT `participante_ibfk_4` FOREIGN KEY (`minicurso_etapa_2`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_model_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `acao` varchar(200) NOT NULL,
  `nome_modelo` varchar(200) DEFAULT NULL,
  `id_modelo` int(11) DEFAULT NULL,
  `data_hora_acao` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `admin_model_history_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `ministrante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `telefone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profissao` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biografia` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresa_universidade` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `tamanho_camiseta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ministrante_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `como_conheceu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `opcao` int(11) NOT NULL,
  `outro` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `como_conheceu_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `dados_hospedagem_transporte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ministrante` int(11) DEFAULT NULL,
  `id_evento` int(11) DEFAULT NULL,
  `cidade_origem` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_chegada_origem` date NOT NULL,
  `data_chegada_partida` date NOT NULL,
  `transporte_ida_volta` tinyint(1) NOT NULL,
  `opcoes_transporte_ida_volta` int(11) DEFAULT NULL,
  `transporte_sanca` tinyint(1) NOT NULL,
  `opcoes_transporte_sanca` int(11) DEFAULT NULL,
  `hospedagem` tinyint(1) NOT NULL,
  `necessidades_hospedagem` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ministrante` (`id_ministrante`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_1` FOREIGN KEY (`id_ministrante`) REFERENCES `ministrante` (`id`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `info_feira_de_projetos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `necessidades` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planejamento` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_feira_de_projetos_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `info_minicurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `pre_requisitos` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planejamento` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apresentacao_extra` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_ide` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_bibliotecas_pacotes` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_dependencias` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_sistema` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_observacoes` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_github` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_hardware` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dicas_instalacao` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_minicurso_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `info_palestra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `planejamento` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apresentacao_extra` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requisitos_tecnicos` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perguntas` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_palestra_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `membro_de_equipe` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `foto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_secomp` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(254) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `pagamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_participante` int(11) DEFAULT NULL,
  `id_camiseta` int(11) DEFAULT NULL,
  `payment_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` float NOT NULL,
  `efetuado` tinyint(1) NOT NULL,
  `arquivo_comprovante` varchar(100) DEFAULT NULL,
  `comprovante_enviado` tinyint(1) NOT NULL,
  `metodo_pagamento` varchar(100) NOT NULL,
  `rejeitado` tinyint(1) NOT NULL,
  `cancelado` tinyint(1) NOT NULL,
  `data_hora_pagamento` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_participante` (`id_participante`),
  KEY `id_camiseta` (`id_camiseta`),
  CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`),
  CONSTRAINT `pagamento_ibfk_2` FOREIGN KEY (`id_camiseta`) REFERENCES `camiseta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `cupom_desconto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pagamento` int(11) DEFAULT NULL,
  `nome` varchar(200) NOT NULL,
  `valor` float NOT NULL,
  `usado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pagamento` (`id_pagamento`),
  CONSTRAINT `cupom_desconto_ibfk_1` FOREIGN KEY (`id_pagamento`) REFERENCES `pagamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `patrocinador` (
  `id` int(11) NOT NULL,
  `nome_empresa` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ativo_site` tinyint(1) NOT NULL,
  `id_cota` int(11) NOT NULL,
  `ordem_site` int(11) DEFAULT NULL,
  `link_website` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ultima_atualizacao_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cota` (`id_cota`),
  CONSTRAINT `patrocinador_ibfk_1` FOREIGN KEY (`id_cota`) REFERENCES `cota_patrocinio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_atividade_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_area` (`id_area`),
  CONSTRAINT `relacao_atividade_area_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_area_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_atividade_participante` (
  `id` int(11) NOT NULL,
  `id_atividade` int(11) DEFAULT NULL,
  `id_participante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `relacao_atividade_participante_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_participante_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_atividade_patrocinador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_patrocinador` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_patrocinador` (`id_patrocinador`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_2` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_patrocinador_evento` (
  `id` int(11) NOT NULL,
  `id_patrocinador` int(11) DEFAULT NULL,
  `id_evento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_patrocinador` (`id_patrocinador`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_1` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_permissao_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_permissao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_permissao` (`id_permissao`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_2` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `relacao_participante_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_flag` int(11) DEFAULT NULL,
  `id_participante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_flag` (`id_flag`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `relacao_participante_flags_ibfk_1` FOREIGN KEY (`id_flag`) REFERENCES `flag` (`id`),
  CONSTRAINT `relacao_participante_flags_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO evento (id, edicao, data_hora_inicio, data_hora_fim, inicio_inscricoes_evento, fim_inscricoes_evento, ano, abertura_minicursos_1_etapa, fechamento_minicursos_1_etapa, abertura_minicursos_2_etapa, fechamento_minicursos_2_etapa) VALUES (1, 10, '2019-09-09 08:30:00', '2019-09-13 18:30:00', '2019-02-10 12:00:00', '2019-08-10 23:59:00', 2019, '2019-08-10 23:59:00', '2019-08-10 23:59:00', '2019-08-10 23:59:00', '2019-08-10 23:59:00');
INSERT INTO curso (id, nome) VALUES (1, 'Ciência da Computação'), (2, 'Engenharia da Computação');
INSERT INTO instituicao (id, nome) VALUES (1, 'UFSCar'), (2, 'USP'), (3, 'UNESP'), (4, 'Unicamp');
INSERT INTO cidade (id, nome) VALUES (1, 'São Carlos'), (2, 'São Paulo'), (3, 'Campinas'),(4, 'Rio Claro');
INSERT INTO camiseta (id, id_evento, tamanho, quantidade, ordem_site, quantidade_restante) VALUES (1, 1, 'P Feminino', 100, 1, 100), (2, 1, 'M Feminino', 100, 2, 100), (3, 1, 'G Feminino', 100, 3, 100), (4, 1, 'GG Feminino', 100, 4, 100), (5, 1, 'P Masculino', 100, 5, 100), (7, 1, 'M Masculino', 100, 7, 100), (8, 1, 'G Masculino', 100, 8, 100), (9, 1, 'GG Masculino', 100, 9, 100);
INSERT INTO diretoria (id, nome, ordem) VALUES (1, 'Coordenação Geral', 1), (2, 'TI', 2), (3, 'Design & Marketing', 3), (4, 'Conteúdo', 4), (5, 'Patrocínio', 5), (6, 'Jurídico-Financeira', 6),(7, 'Sócio-Cultural', 7);
INSERT INTO cargo (id, nome) VALUES (1, 'Membro'), (2, 'Diretora'), (3, 'Diretor'), (4, 'Voluntária'), (5, 'Voluntário');
INSERT INTO cota_patrocinio (id, nome) VALUES (1, 'Diamante'), (2, 'Ouro'), (3, 'Prata'), (4, 'Apoio');
INSERT INTO permissao (id, nome) VALUES (1, 'CONTEUDO'), (2, 'MINISTRANTE'), (3, 'PATROCINIO'), (4, 'ADMIN'), (5, 'NOTIFICACOES_APP'), (6, 'VENDA_PRESENCIAL'), (7, 'APROVAR_COMPROVANTES'), (8, 'ALTERAR_CAMISETAS'), (9, 'GERAR_CRACHAS'), (10, 'GERAR_LISTAS'), (11, 'SORTEAR');
INSERT INTO `tipo_atividade` (`id`, `nome`) VALUES ('1', 'Minicurso'), ('2', 'Palestra'), ('3', 'Mesa Redonda'), ('4', 'Palestra Empresarial'), ('5', 'Feira de Projetos'), ('6', 'Workshop'), ('7', 'Roda de Conversa');
