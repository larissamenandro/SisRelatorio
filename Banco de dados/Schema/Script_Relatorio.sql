	begin transaction;
	
	/*==============================================================*/
	/* dbms name:      postgresql 9.4                               */
	/* created on:     01/12/2015 		                            */
	/*==============================================================*/

	begin transaction;
	set statement_timeout = 0;
	set client_encoding = 'utf8';
	set standard_conforming_strings = on;
	set check_function_bodies = false;
	set client_min_messages = warning;


	-- -----------------------------------------------------------------------
	-- --------------- s c h e m a   R E L A T O R I O  ------------------
	-- -----------------------------------------------------------------------
	--
	-- criação do schema
	create schema relatorio;
	alter schema relatorio owner to postgres;
	set search_path = relatorio, pg_catalog;
	set default_tablespace = '';
	set default_with_oids = false;

rollback transaction;