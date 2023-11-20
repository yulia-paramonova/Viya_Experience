proc cas;
table.dropTable /caslib="casuser", name="DONNEES_INSEE" quiet=TRUE;
/* table.loadTable / path="DONNEES_INSEE.sashdat", caslib="casuser", casout={caslib="casuser", name="DONNEES_INSEE", replace=TRUE}; */
table.loadTable / path="DONNEES_INSEE.sashdat", caslib="swee", casout={caslib="casuser", name="DONNEES_INSEE", replace=TRUE};
quit;

/* proc cas; */
/* table.save / caslib="swee" name="DONNEES_INSEE"||".sashdat" table={name="donnees_insee", caslib="casuser"} replace=true; */
/* quit;  */

proc sql;
%if %sysfunc(exist(CASUSER.donnees_insee1)) %then %do;
    drop table CASUSER.donnees_insee1;
%end;
%if %sysfunc(exist(CASUSER.donnees_insee1,VIEW)) %then %do;
    drop view CASUSER.donnees_insee1;
%end;
quit;
;
PROC FEDSQL SESSREF=mysession;
	CREATE TABLE CASUSER."donnees_insee1" AS
		SELECT
			(t1.CODE_DEPT) as "Code Département",
			(t1.CODE_REG) as "Code Région",
			(t1."CODE_COM") AS "Code Commune",
/* 			(t1."NOM_REG") AS "Region", */
/* 			(t1."NOM_DEPT") AS "Departement", */
/* 			(t1."NOM_COM") AS "Commune", */
			(t1."Z_MOYEN") AS "Altitude Moyenne",
			(t1."POPULATION") AS "Population"
		FROM
			CASUSER."DONNEES_INSEE" t1
	;
QUIT;
RUN;

proc means data=casuser.donnees_insee1 min P1 P99 max mean n nmiss; run; 


data casuser.donnees_insee2;
set casuser.donnees_insee1;
if Population=0 then population=.;
if "Altitude Moyenne"n =0 then "Altitude Moyenne"n=.;
if 'Code Département'n=. then 'Code Département'n=999;
run; 

proc means data=casuser.donnees_insee2 min P1 P99 max mean n nmiss; run; 

proc cas;
table.dropTable /caslib="casuser", name="donnees_insee" quiet=TRUE;
table.dropTable /caslib="casuser", name="donnees_insee1" quiet=TRUE;
table.promote / name="donnees_insee2", caslib="casuser",  target="donnees_insee",  targetLib="casuser";
quit; 

/* caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com'; */
/* proc cas; */
/* table.save / caslib="yulia" name="DONNEES_INSEE"||".sashdat" table={name="donnees_insee", caslib="casuser"} replace=true; */
/* quit;  */