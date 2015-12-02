	begin transaction;
	
	/*==============================================================*/
	/* dbms name:      postgresql 9.4                               */
	/* created on:     01/12/2015 	
	/* author:		   Larissa Menandro	                            */
	/*==============================================================*/

	begin transaction;
	set statement_timeout = 0;
	set client_encoding = 'utf8';
	set standard_conforming_strings = on;
	set check_function_bodies = false;
	set client_min_messages = warning;


	-- -----------------------------------------------------------------------
	-- --------------- s c h e m a   R E L A T Ó R I O  ------------------
	-- -----------------------------------------------------------------------
	--
	-- criação do schema
	create schema relatorio;
	alter schema relatorio owner to postgres;
	set search_path = relatorio, pg_catalog;
	set default_tablespace = '';
	set default_with_oids = false;



/*==============================================================*/
/* Table: BIOPSIA                                               */
/*==============================================================*/
create table BIOPSIA 
(
   ID_BIOPSIA           serial                         not null,
   ID_PACIENTE          int8                           null,
   NUMERO_BIOPSIA       int4                           null,
   NUMERO_BLOCOS_       int4                           null,
   DATA                 date                           null,
   OBSERVACAO           text		                   null,
   constraint PK_BIOPSIA primary key  (ID_BIOPSIA)
);

comment on column BIOPSIA.ID_BIOPSIA is 
'PK da tabela';

comment on column BIOPSIA.ID_PACIENTE is 
'FK para tb_id_paciente';

comment on column BIOPSIA.OBSERVACAO is 
'Campo usado para abrir um espaço no cadastro caso o usuario precise informar mais dados sobre a biopsia, como o resultado detalhado.';

/*==============================================================*/
/* Table: BIOPSIA_HAS_MATERIAL                                  */
/*==============================================================*/
create table BIOPSIA_HAS_MATERIAL 
(
   ID_BIOPSIA_HAS_MATERIAL serial                         not null,
   ID_BIOPSIA           int8                           null,
   ID_MATERIAL          int8                           null,
   constraint PK_BIOPSIA_HAS_MATERIAL primary key  (ID_BIOPSIA_HAS_MATERIAL)
);

comment on column BIOPSIA_HAS_MATERIAL.ID_BIOPSIA_HAS_MATERIAL is 
'PK da tabela';

comment on column BIOPSIA_HAS_MATERIAL.ID_BIOPSIA is 
'FK para tb_biopsia';

comment on column BIOPSIA_HAS_MATERIAL.ID_MATERIAL is 
'FK para tb_material';

/*==============================================================*/
/* Table: MATERIAL                                              */
/*==============================================================*/
create table MATERIAL 
(
   ID_MATERIAL          Serial                         not null,
   ID_PACIENTE          int8                           null,
   ID_TIPO_MATERIAL     int8                           null,
   DESCRICAO            varchar(200)                   null,
   constraint PK_MATERIAL primary key  (ID_MATERIAL)
);

comment on column MATERIAL.ID_MATERIAL is 
'PK da tabela';

comment on column MATERIAL.ID_PACIENTE is 
'FK para tb_paciente';

comment on column MATERIAL.ID_TIPO_MATERIAL is 
'PK da tabela';

comment on column MATERIAL.DESCRICAO is 
'Descrição do material recolhido para biopsia/Nome';

/*==============================================================*/
/* Table: PACIENTE                                              */
/*==============================================================*/
create table PACIENTE 
(
   ID_PACIENTE          int4                           not null,
   NOME                 varchar(100)                   null,
   SEXO                 char(1)                        null,
   REGISTRO             varchar(45)                    null,
   IDADE                int2                           null,
   constraint PK_PACIENTE primary key  (ID_PACIENTE)
);

comment on column PACIENTE.ID_PACIENTE is 
'PK da tabela composto pelo número do SUS do paciente';

/*==============================================================*/
/* Table: TB_TIPO_MATERIAL                                      */
/*==============================================================*/
create table TB_TIPO_MATERIAL 
(
   ID_TIPO_MATERIAL     serial                         not null,
   TIPO_MATERIAL        int2                           null,
   constraint PK_TB_TIPO_MATERIAL primary key  (ID_TIPO_MATERIAL)
);

comment on table TB_TIPO_MATERIAL is 
'Entidade que especifica quais tipos de materiais recolhidos para fazer a biopsia. ';

comment on column TB_TIPO_MATERIAL.ID_TIPO_MATERIAL is 
'PK da tabela';

comment on column TB_TIPO_MATERIAL.TIPO_MATERIAL is 
'Os tipos de materiais definem qual é o material retirado para a biopsia. Conforme forem surgindo necessidade novos tipos serão criados. 

Tipos 
1 - Biópsia de Mama
2 - Biópsia de Próstata
3 - Outros';

alter table BIOPSIA
   add constraint FK_BIOPSIA_REFERENCE_PACIENTE foreign key (ID_PACIENTE)
      references PACIENTE (ID_PACIENTE)
      on update restrict
      on delete restrict;

alter table BIOPSIA_HAS_MATERIAL
   add constraint FK_BIOPSIA__REFERENCE_MATERIAL foreign key (ID_MATERIAL)
      references MATERIAL (ID_MATERIAL)
      on update restrict
      on delete restrict;

alter table BIOPSIA_HAS_MATERIAL
   add constraint FK_BIOPSIA__TB_BIOPSI_BIOPSIA foreign key (ID_BIOPSIA)
      references BIOPSIA (ID_BIOPSIA)
      on update restrict
      on delete restrict;

alter table MATERIAL
   add constraint FK_MATERIAL_REFERENCE_PACIENTE foreign key (ID_PACIENTE)
      references PACIENTE (ID_PACIENTE)
      on update restrict
      on delete restrict;

alter table MATERIAL
   add constraint FK_MATERIAL_REFERENCE_TB_TIPO_ foreign key (ID_TIPO_MATERIAL)
      references TB_TIPO_MATERIAL (ID_TIPO_MATERIAL)
      on update restrict
      on delete restrict;


 rollback transaction;