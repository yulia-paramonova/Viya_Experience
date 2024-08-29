proc cas; *drop la table si existe dans casuser et charger depuis swee;
table.dropTable /caslib="casuser", name="VHO_ACCIDENTS_CORPORELS" quiet=TRUE;
table.dropTable /caslib="casuser", name="ACCIDENTS_CORPORELS" quiet=TRUE;
table.loadTable / path="VHO_ACCIDENTS_CORPORELS.sashdat", caslib="swee", casout={caslib="casuser", name="VHO_ACCIDENTS_CORPORELS", replace=TRUE};
quit;


/* *******************************************AVEC création de valeurs manquantes******************************************************************************** */

/* proc means data=casuser.VHO_ACCIDENTS_CORPORELS min P1 P99 max mean n nmiss; run;  */
/*  */
/* data casuser.VHO_ACCIDENTS_CORPORELS2; * créer des valeurs manquantes; */
/* set casuser.VHO_ACCIDENTS_CORPORELS; */
/* if 'largeur_chaussée'n <= 1 then 'largeur_chaussée'n=.; */
/* if v_max < 1 then v_max = . ; */
/* run;  */
/*  */
/* proc means data=casuser.VHO_ACCIDENTS_CORPORELS2 min P1 P99 max mean n nmiss; run;  */

/* proc cas; *promote la table; */
/* table.dropTable /caslib="casuser", name="VHO_ACCIDENTS_CORPORELS" quiet=TRUE; */
/* table.promote / name="VHO_ACCIDENTS_CORPORELS2", caslib="casuser",  target="ACCIDENTS_CORPORELS",  targetLib="casuser"; */
/* quit;  */

/* ********************************************SANS création de valeurs manquantes******************************************************************************* */
proc cas; *promote la table;
table.promote / name="VHO_ACCIDENTS_CORPORELS", caslib="casuser",  target="ACCIDENTS_CORPORELS",  targetLib="casuser";
quit; 


proc cas; *ajouter des labels;
table.alterTable /
caslib="casuser"
columns={{label="Numéro d'accident", name="Num_Acc"},
{label="Date", name="date"},
{label="Latitude", name="lat"},
{label="Longitude", name="long"},
{label="Catégorie", name="categorie"},
{label="Vitesse maximale", name="v_max"},
{label="Plan", name="plan"},
{label="Largeur terre-plein central", name="largeur_TPC"},
{label="Largeur chaussée", name="largeur_chaussée"},
{label="Etat surface", name="etat_surface"},
{label="Aménagement", name="Aménagement"},
{label="Situation de l'accident", name="Situation_accident"},
{label="Département", name="dep"}}
name="ACCIDENTS_CORPORELS"
;
quit; 


proc cas; *drop la table;
table.dropTable /caslib="casuser", name="ACCIDENTS_CORPORELS_prep" quiet=TRUE;
quit; 

PROC FEDSQL SESSREF=mysession;
   CREATE TABLE casuser.ACCIDENTS_CORPORELS_prep  AS
   SELECT 
      t1."dep",
      (COUNT(t1.Num_Acc)) AS "COUNT_Num_Acc",
      (avg(t1.v_max)) AS "MEAN_v_max",
      (avg(t1.largeur_TPC)) AS "MEAN_largeur_TPC",
      (avg(t1."largeur_chaussée")) AS "MEAN_largeur_chaussée"
   FROM
      casuser."ACCIDENTS_CORPORELS" t1

   GROUP BY
      t1."dep"
   ;
QUIT;
RUN;


proc cas; *ajouter des labels;
table.alterTable /
caslib="casuser"
columns={{label="Nombre d'accidents", name="COUNT_Num_Acc"},
{label="Moyenne des Vitesses maximales", name="MEAN_v_max"},
{label="Moyenne Largeur terre-plein central", name="MEAN_largeur_TPC"},
{label="Moyenne Largeur chaussée", name="MEAN_largeur_chaussée"}}
name="ACCIDENTS_CORPORELS_prep"
;
table.promote / name="ACCIDENTS_CORPORELS_prep", caslib="casuser",  target="ACCIDENTS_CORPORELS_prep",  targetLib="casuser";
quit; 




/* caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com'; */
/* proc cas; */
/* table.save / caslib="yulia" name="ACCIDENTS_CORPORELS"||".sashdat" table={name="ACCIDENTS_CORPORELS", caslib="casuser"} replace=true; */
/* quit;  */

/* caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com'; */
/* proc cas; */
/* table.save / caslib="yulia" name="ACCIDENTS_CORPORELS_prep"||".sashdat" table={name="ACCIDENTS_CORPORELS_prep", caslib="casuser"} replace=true; */
/* quit;  */

/* proc cas; */
/* table.deleteSource / caslib="yulia" quiet=FALSE source="ACCIDENTS_CORPORELS"||".sashdat"; */
/* quit; */