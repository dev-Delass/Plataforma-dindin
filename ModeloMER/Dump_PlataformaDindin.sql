CREATE DATABASE  IF NOT EXISTS `plataformadindin` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `plataformadindin`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: plataformadindin
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `nome_aluno` varchar(20) NOT NULL,
  `sobrenome_aluno` varchar(30) NOT NULL,
  `cpf` char(11) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` enum('M','F') DEFAULT NULL,
  `nacionalidade` varchar(20) DEFAULT 'Brasil',
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula_aluno`
--

DROP TABLE IF EXISTS `aula_aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula_aluno` (
  `data_acesso` date NOT NULL,
  `cod_aluno` char(11) NOT NULL,
  `cod_aula` int NOT NULL,
  `cod_curso` int NOT NULL,
  KEY `fk_aula_aluno` (`cod_aluno`),
  KEY `fk_aula` (`cod_aula`),
  KEY `fk_curso_aula` (`cod_curso`),
  CONSTRAINT `fk_aula` FOREIGN KEY (`cod_aula`) REFERENCES `aulas_curso` (`id_aula`),
  CONSTRAINT `fk_aula_aluno` FOREIGN KEY (`cod_aluno`) REFERENCES `alunos` (`cpf`),
  CONSTRAINT `fk_curso_aula` FOREIGN KEY (`cod_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula_aluno`
--

LOCK TABLES `aula_aluno` WRITE;
/*!40000 ALTER TABLE `aula_aluno` DISABLE KEYS */;
/*!40000 ALTER TABLE `aula_aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aulas_curso`
--

DROP TABLE IF EXISTS `aulas_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aulas_curso` (
  `id_aula` int NOT NULL AUTO_INCREMENT,
  `cod_curso` int NOT NULL,
  `nome_aula` varchar(50) NOT NULL,
  `descrição` text,
  `duracao` int unsigned DEFAULT NULL,
  `ano` year DEFAULT NULL,
  `aula_prof` char(11) NOT NULL,
  PRIMARY KEY (`id_aula`),
  UNIQUE KEY `nome_aula` (`nome_aula`),
  KEY `fk_aulas_prof` (`aula_prof`),
  KEY `fk_aulas_curso` (`cod_curso`),
  CONSTRAINT `fk_aulas_curso` FOREIGN KEY (`cod_curso`) REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `fk_aulas_prof` FOREIGN KEY (`aula_prof`) REFERENCES `professores` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas_curso`
--

LOCK TABLES `aulas_curso` WRITE;
/*!40000 ALTER TABLE `aulas_curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `aulas_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatos`
--

DROP TABLE IF EXISTS `contatos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contatos` (
  `email` varchar(50) NOT NULL,
  `ddd_telefone` char(3) DEFAULT NULL,
  `numero_tellefone` char(10) DEFAULT NULL,
  `contato_aluno` char(11) NOT NULL,
  `contato_prof` char(11) NOT NULL,
  PRIMARY KEY (`email`),
  KEY `fk_contato_aluno` (`contato_aluno`),
  KEY `fk_contatos_prof` (`contato_prof`),
  CONSTRAINT `fk_contato_aluno` FOREIGN KEY (`contato_aluno`) REFERENCES `alunos` (`cpf`),
  CONSTRAINT `fk_contatos_prof` FOREIGN KEY (`contato_prof`) REFERENCES `professores` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatos`
--

LOCK TABLES `contatos` WRITE;
/*!40000 ALTER TABLE `contatos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_aluno`
--

DROP TABLE IF EXISTS `curso_aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_aluno` (
  `data_cadastro` date DEFAULT NULL,
  `cod_aluno` char(11) NOT NULL,
  `cod_curso` int NOT NULL,
  KEY `fk_curso_aluno` (`cod_aluno`),
  KEY `fk_curso` (`cod_curso`),
  CONSTRAINT `fk_curso` FOREIGN KEY (`cod_curso`) REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `fk_curso_aluno` FOREIGN KEY (`cod_aluno`) REFERENCES `alunos` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_aluno`
--

LOCK TABLES `curso_aluno` WRITE;
/*!40000 ALTER TABLE `curso_aluno` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso_aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(50) NOT NULL,
  `descrição` text,
  `carga_horaria` int unsigned DEFAULT NULL,
  `total_aulas` int DEFAULT NULL,
  `ano` year DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  UNIQUE KEY `nome_curso` (`nome_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depoimentos`
--

DROP TABLE IF EXISTS `depoimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depoimentos` (
  `descricao` text NOT NULL,
  `id_depoimento` int NOT NULL AUTO_INCREMENT,
  `data_depoimento` date NOT NULL,
  `id_usuario` int NOT NULL,
  `cod_aluno` char(11) NOT NULL,
  `cod_prof` char(11) NOT NULL,
  PRIMARY KEY (`id_depoimento`),
  KEY `fk_depoimento_usuario` (`id_usuario`),
  KEY `fk_depoimentos_aluno` (`cod_aluno`),
  KEY `fk_depoimentos_prof` (`cod_prof`),
  CONSTRAINT `fk_depoimento_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_depoimentos_aluno` FOREIGN KEY (`cod_aluno`) REFERENCES `alunos` (`cpf`),
  CONSTRAINT `fk_depoimentos_prof` FOREIGN KEY (`cod_prof`) REFERENCES `professores` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depoimentos`
--

LOCK TABLES `depoimentos` WRITE;
/*!40000 ALTER TABLE `depoimentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `depoimentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `id_endereco` int NOT NULL AUTO_INCREMENT,
  `logradouro_rua` varchar(60) NOT NULL,
  `numero_casa` int DEFAULT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `cep` char(8) NOT NULL,
  `endereco_aluno` char(11) NOT NULL,
  `endereco_prof` char(11) NOT NULL,
  PRIMARY KEY (`id_endereco`),
  KEY `fk_endereco_aluno` (`endereco_aluno`),
  KEY `fk_endereco_prof` (`endereco_prof`),
  CONSTRAINT `fk_endereco_aluno` FOREIGN KEY (`endereco_aluno`) REFERENCES `alunos` (`cpf`),
  CONSTRAINT `fk_endereco_prof` FOREIGN KEY (`endereco_prof`) REFERENCES `professores` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_blog`
--

DROP TABLE IF EXISTS `post_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_blog` (
  `id_post` int NOT NULL AUTO_INCREMENT,
  `data_post` date NOT NULL,
  `titulo_post` varchar(100) DEFAULT NULL,
  `descricao` text,
  `foto_post` varchar(100) DEFAULT NULL,
  `conteudo` longtext,
  PRIMARY KEY (`id_post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_blog`
--

LOCK TABLES `post_blog` WRITE;
/*!40000 ALTER TABLE `post_blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professores`
--

DROP TABLE IF EXISTS `professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professores` (
  `nome_prof` varchar(20) NOT NULL,
  `sobrenome_prof` varchar(30) NOT NULL,
  `cpf` char(11) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` enum('M','F') DEFAULT NULL,
  `nacionalidade` varchar(20) DEFAULT 'Brasil',
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professores`
--

LOCK TABLES `professores` WRITE;
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `email_login` varchar(50) NOT NULL,
  `senha_usuario` varchar(20) NOT NULL,
  `foto_usuario` varchar(100) DEFAULT NULL,
  `cod_aluno` char(11) NOT NULL,
  `cod_prof` char(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_usuario_aluno` (`cod_aluno`),
  KEY `fk_usuario_prof` (`cod_prof`),
  KEY `fk_usuario_login` (`email_login`),
  CONSTRAINT `fk_usuario_aluno` FOREIGN KEY (`cod_aluno`) REFERENCES `alunos` (`cpf`),
  CONSTRAINT `fk_usuario_login` FOREIGN KEY (`email_login`) REFERENCES `contatos` (`email`),
  CONSTRAINT `fk_usuario_prof` FOREIGN KEY (`cod_prof`) REFERENCES `professores` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_post_blog`
--

DROP TABLE IF EXISTS `usuario_post_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_post_blog` (
  `data_acesso` date NOT NULL,
  `cod_post` int NOT NULL,
  `cod_usuario` int NOT NULL,
  KEY `fk_post_blog` (`cod_post`),
  KEY `fk_usuario_post_blog` (`cod_usuario`),
  CONSTRAINT `fk_post_blog` FOREIGN KEY (`cod_post`) REFERENCES `post_blog` (`id_post`),
  CONSTRAINT `fk_usuario_post_blog` FOREIGN KEY (`cod_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_post_blog`
--

LOCK TABLES `usuario_post_blog` WRITE;
/*!40000 ALTER TABLE `usuario_post_blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_post_blog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-12 23:33:38
