proc cas; *drop la table si existe dans casuser et charger depuis swee;
table.dropTable /caslib="casuser", name="VHO_ACCIDENTS_CORPORELS" quiet=TRUE;
table.loadTable / path="VHO_ACCIDENTS_CORPORELS.sashdat", caslib="swee", casout={caslib="casuser", name="VHO_ACCIDENTS_CORPORELS", replace=TRUE};
quit;

proc means data=casuser.VHO_ACCIDENTS_CORPORELS min P1 P99 max mean n nmiss; run; 

data casuser.VHO_ACCIDENTS_CORPORELS2; * créer des valeurs manquantes;
set casuser.VHO_ACCIDENTS_CORPORELS;
if 'largeur_chaussée'n <= 1 then 'largeur_chaussée'n=.;
if v_max < 1 then v_max = . ;
run; 

proc means data=casuser.VHO_ACCIDENTS_CORPORELS2 min P1 P99 max mean n nmiss; run; 

proc cas; *promote la table;
table.dropTable /caslib="casuser", name="VHO_ACCIDENTS_CORPORELS" quiet=TRUE;
table.promote / name="VHO_ACCIDENTS_CORPORELS2", caslib="casuser",  target="ACCIDENTS_CORPORELS",  targetLib="casuser";
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


/* caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com'; */
/* proc cas; */
/* table.save / caslib="yulia" name="ACCIDENTS_CORPORELS"||".sashdat" table={name="ACCIDENTS_CORPORELS", caslib="casuser"} replace=true; */
/* quit;  */

