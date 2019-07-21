DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(48) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOCK TABLES `area` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `cidade`;
CREATE TABLE `cidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

LOCK TABLES `cidade` WRITE;

INSERT INTO `cidade` VALUES (0,'Outro'),(1,'São Carlos'),(2,'São Paulo'),(3,'Campinas'),(4,'Rio Claro');

UNLOCK TABLES;

DROP TABLE IF EXISTS `instituicao`;

CREATE TABLE `instituicao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

LOCK TABLES `instituicao` WRITE;
INSERT INTO `instituicao` VALUES (0,'Outro'),(1,'UFSCar'),(2,'USP'),(3,'UNESP'),(4,'Unicamp');
UNLOCK TABLES;

DROP TABLE IF EXISTS `patrocinador`;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `patrocinador` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `cota_patrocinio`;

CREATE TABLE `cota_patrocinio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

LOCK TABLES `cota_patrocinio` WRITE;

INSERT INTO `cota_patrocinio` VALUES (1,'Diamante'),(2,'Ouro'),(3,'Prata'),(4,'Apoio');

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_patrocinador_evento`;

CREATE TABLE `relacao_patrocinador_evento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_patrocinador` int(11) DEFAULT NULL,
  `id_evento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  KEY `id_patrocinador` (`id_patrocinador`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `relacao_patrocinador_evento_ibfk_2` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_patrocinador_evento` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `membro_de_equipe`;

CREATE TABLE `membro_de_equipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `email_secomp` varchar(254) DEFAULT NULL,
  `id_cargo` int(11) NOT NULL,
  `id_diretoria` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cargo` (`id_cargo`),
  KEY `id_diretoria` (`id_diretoria`),
  KEY `id_evento` (`id_evento`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `membro_de_equipe_ibfk_1` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_2` FOREIGN KEY (`id_diretoria`) REFERENCES `diretoria` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_3` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `membro_de_equipe_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `membro_de_equipe` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `permissao`;

CREATE TABLE `permissao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

LOCK TABLES `permissao` WRITE;

INSERT INTO `permissao` VALUES (1,'CONTEUDO'),(2,'MINISTRANTE');

UNLOCK TABLES;

DROP TABLE IF EXISTS `participante`;

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
  KEY `id_camiseta` (`id_camiseta`),
  KEY `id_evento` (`id_evento`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `participante_ibfk_1` FOREIGN KEY (`id_camiseta`) REFERENCES `camiseta` (`id`),
  CONSTRAINT `participante_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `participante_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `participante` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `presenca`;

CREATE TABLE `presenca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_hora_registro` datetime NOT NULL,
  `id_atividade` int(11) NOT NULL,
  `id_participante` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `inscrito` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_evento` (`id_evento`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `presenca_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `presenca_ibfk_2` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `presenca_ibfk_3` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `presenca` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `atividade`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `atividade` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `cargo`;

CREATE TABLE `cargo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

LOCK TABLES `cargo` WRITE;

INSERT INTO `cargo` VALUES (1,'Membro'),(2,'Diretora'),(3,'Diretor'),(4,'Voluntária'),(5,'Voluntário');

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_atividade_patrocinador`;

CREATE TABLE `relacao_atividade_patrocinador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_patrocinador` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_patrocinador` (`id_patrocinador`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_patrocinador_ibfk_2` FOREIGN KEY (`id_patrocinador`) REFERENCES `patrocinador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_atividade_patrocinador` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `evento`;

CREATE TABLE `evento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `edicao` int(11) NOT NULL,
  `data_hora_inicio` datetime NOT NULL,
  `data_hora_fim` datetime NOT NULL,
  `inicio_inscricoes_evento` datetime NOT NULL,
  `fim_inscricoes_evento` datetime NOT NULL,
  `ano` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `evento` WRITE;

INSERT INTO `evento` VALUES (1,10,'2019-09-09 08:30:00','2019-09-13 18:30:00','2019-02-10 12:00:00','2019-08-10 23:59:00',2019);
UNLOCK TABLES;

DROP TABLE IF EXISTS `info_palestra`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `info_palestra` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `ministrante`;

CREATE TABLE `ministrante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `profissao` varchar(64) DEFAULT NULL,
  `empresa_universidade` varchar(64) DEFAULT NULL,
  `biografia` varchar(1500) DEFAULT NULL,
  `foto` varchar(128) DEFAULT NULL,
  `tamanho_camiseta` int(11) DEFAULT NULL,
  `facebook` varchar(64) DEFAULT NULL,
  `twitter` varchar(64) DEFAULT NULL,
  `linkedin` varchar(64) DEFAULT NULL,
  `github` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ministrante_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ministrante` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_atividade_area`;

CREATE TABLE `relacao_atividade_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_area` (`id_area`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `relacao_atividade_area_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `area` (`id`),
  CONSTRAINT `relacao_atividade_area_ibfk_2` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_atividade_area` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_atividade_ministrante`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_atividade_ministrante` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `camiseta`;

CREATE TABLE `camiseta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_evento` int(11) NOT NULL,
  `tamanho` varchar(30) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `ordem_site` int(11) NOT NULL,
  `quantidade_restante` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_evento` (`id_evento`),
  CONSTRAINT `camiseta_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

LOCK TABLES `camiseta` WRITE;

INSERT INTO `camiseta` VALUES (1,1,'P Feminino',100,1,100),(2,1,'M Feminino',100,2,100),(3,1,'G Feminino',100,3,100),(4,1,'GG Feminino',100,4,100),(5,1,'P Masculino',100,5,100),(7,1,'M Masculino',100,7,100),(8,1,'G Masculino',100,8,100),(9,1,'GG Masculino',100,9,100);

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_permissao_usuario`;

CREATE TABLE `relacao_permissao_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_permissao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_permissao` (`id_permissao`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_1` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id`),
  CONSTRAINT `relacao_permissao_usuario_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_permissao_usuario` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `tipo_atividade`;

CREATE TABLE `tipo_atividade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

LOCK TABLES `tipo_atividade` WRITE;

INSERT INTO `tipo_atividade` VALUES (1,'Palestra'),(2,'Minicurso'),(3,'Palestra Empresarial'),(4,'Mesa Redonda'),(5,'Workshop'),(6,'Feira de Projetos');

UNLOCK TABLES;

DROP TABLE IF EXISTS `diretoria`;

CREATE TABLE `diretoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `ordem` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

LOCK TABLES `diretoria` WRITE;

INSERT INTO `diretoria` VALUES (1,'Coordenação Geral',1),(2,'TI',2),(3,'Design & Marketing',3),(4,'Conteúdo',4),(5,'Patrocínio',5),(6,'Jurídico-Financeira',6),(7,'Sócio-Cultural',7);

UNLOCK TABLES;

DROP TABLE IF EXISTS `curso`;

CREATE TABLE `curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `curso` WRITE;

INSERT INTO `curso` VALUES (0,'Outro'),(1,'Ciência da Computação'),(2,'Engenharia da Computação');

UNLOCK TABLES;

DROP TABLE IF EXISTS `info_minicurso`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `info_minicurso` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `usuario`;

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
  KEY `id_cidade` (`id_cidade`),
  KEY `id_curso` (`id_curso`),
  KEY `id_instituicao` (`id_instituicao`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`),
  CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `dados_hospedagem_transporte`;

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
  KEY `id_evento` (`id_evento`),
  KEY `id_ministrante` (`id_ministrante`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id`),
  CONSTRAINT `dados_hospedagem_transporte_ibfk_2` FOREIGN KEY (`id_ministrante`) REFERENCES `ministrante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `dados_hospedagem_transporte` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `info_feira_de_projetos`;

CREATE TABLE `info_feira_de_projetos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `necessidades` varchar(1024) DEFAULT NULL,
  `planejamento` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  CONSTRAINT `info_feira_de_projetos_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `info_feira_de_projetos` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `relacao_atividade_participante`;

CREATE TABLE `relacao_atividade_participante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_atividade` int(11) DEFAULT NULL,
  `id_participante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_atividade` (`id_atividade`),
  KEY `id_participante` (`id_participante`),
  CONSTRAINT `relacao_atividade_participante_ibfk_1` FOREIGN KEY (`id_atividade`) REFERENCES `atividade` (`id`),
  CONSTRAINT `relacao_atividade_participante_ibfk_2` FOREIGN KEY (`id_participante`) REFERENCES `participante` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `relacao_atividade_participante` WRITE;

UNLOCK TABLES;
