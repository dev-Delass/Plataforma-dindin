create database PlataformaDindin
default character set utf8
default collate utf8_general_ci;

use plataformadindin;

create table alunos( 
nome_aluno      varchar(20) not null,
sobrenome_aluno varchar(30) not null,
cpf              char(11)   not null,
data_nascimento date,
sexo            enum('M', 'F'),
nacionalidade   varchar(20) default 'Brasil', 
constraint pk_aluno primary key(cpf)
)default charset = utf8;

desc alunos;

create table professores(
nome_prof      varchar(20)  not null,
sobrenome_prof varchar(30)  not null,
cpf              char(11)   not null, 
data_nascimento  date, 
sexo             enum('M', 'F'),
nacionalidade  varchar(20)  default 'Brasil',
constraint pk_professor primary key(cpf)
)default charset = UTF8;

desc professores;

create table contatos(
email            varchar(50)  not null, 
ddd_telefone     char(3)  null,
numero_tellefone char(10) null,
contato_aluno    char(11) not null,
contato_prof      char(11) not null,
constraint pk_contatos primary key(email),
constraint fk_contato_aluno foreign key(contato_aluno) references alunos(cpf),
constraint fk_contatos_prof foreign key(contato_prof) references professores(cpf)
)default charset = utf8;

desc contatos;

create table usuario(
id_usuario       int      not null auto_increment,
email_login   varchar(50) not null, 
senha_usuario varchar(20) not null,
foto_usuario  varchar(100), 
cod_aluno         char(11) not null,
cod_prof          char(11) not null,
constraint pk_usuario primary key(id_usuario),
constraint fk_usuario_aluno foreign key(cod_aluno) references alunos(cpf),
constraint fk_usuario_prof foreign key(cod_prof) references professores(cpf),
constraint fk_usuario_login foreign key(email_login) references contatos(email)
)default charset = utf8; 

desc usuario; 

create table endereco(
id_endereco        int      not null auto_increment,
logradouro_rua  varchar(60) not null,
numero_casa       int           null,
complemento     varchar(30)     null,
cep               char(8)   not null,
endereco_aluno    char(11) not null,
endereco_prof     char(11) not null,
constraint pk_endereco primary key(id_endereco),
constraint fk_endereco_aluno foreign key(endereco_aluno) references alunos(cpf),
constraint fk_endereco_prof foreign key(endereco_prof) references professores(cpf)
)default charset = utf8;

desc endereco;

create table cursos(
id_curso      int not null auto_increment,
nome_curso    varchar(50) not null unique,
descrição     text,
carga_horaria int unsigned,
total_aulas   int,
ano           year,
constraint pk_cursos primary key (id_curso)
)default charset = utf8;

desc cursos;

create table aulas_curso(
id_aula   int not null auto_increment,
cod_curso int not null,
nome_aula varchar(50) not null unique,
descrição text,
duracao   int unsigned,
ano       year,
aula_prof char(11) not null,
constraint pk_aulas_curso primary key(id_aula),
constraint fk_aulas_prof foreign key(aula_prof) references professores(cpf),
constraint fk_aulas_curso foreign key(cod_curso) references cursos(id_curso)
)default charset = utf8;

desc aulas_curso;

create table curso_aluno(
data_cadastro date,
cod_aluno char(11) not null,
cod_curso int not null,
constraint fk_curso_aluno foreign key(cod_aluno) references alunos(cpf),
constraint fk_curso foreign key(cod_curso) references cursos(id_curso)
)default charset = utf8;

desc curso_aluno;

create table aula_aluno(
data_acesso date not null, 
cod_aluno char(11) not null,
cod_aula  int not null,
cod_curso int not null,
constraint fk_aula_aluno foreign key(cod_aluno) references alunos(cpf),
constraint fk_aula foreign key(cod_aula) references aulas_curso(id_aula),
constraint fk_curso_aula foreign key(cod_curso) references cursos(id_curso)
)default charset = utf8;

desc aula_aluno;

create table depoimentos(
id_depoimento   int not null auto_increment,
data_depoimento date not null,
id_usuario      int not null,
cod_aluno       char(11) not null,
cod_prof        char(11) not null,
constraint pk_depoimentos primary key(id_depoimento),
constraint fk_depoimento_usuario foreign key(id_usuario) references usuario(id_usuario),
constraint fk_depoimentos_aluno foreign key(cod_aluno) references alunos(cpf),
constraint fk_depoimentos_prof foreign key(cod_prof) references professores(cpf)
)default charset = utf8;

create table post_blog(
id_post     int not null auto_increment,
data_post date not null,
titulo_post varchar(100),
descricao   text,
foto_post   varchar(100),
conteudo    longtext,
constraint pk_post_blog primary key(id_post)
)default charset = utf8;

create table usuario_post_blog(
data_acesso date not null,
cod_post    int not null,
cod_usuario int not null,
constraint fk_post_blog foreign key(cod_post) references post_blog(id_post),
constraint fk_usuario_post_blog foreign key(cod_usuario) references usuario(id_usuario)
)default charset = utf8;

alter table depoimentos 
add column descricao text not null first;