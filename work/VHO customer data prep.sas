libname swee cas caslib="swee";
proc cas; *drop la table si existe dans casuser;
table.dropTable /caslib="casuser", name="INSURANCE_CUSTOMER_DATA" quiet=TRUE;
/* table.loadTable / path="VHO_INSURANCE_CUSTOMER_DATA.sashdat", caslib="swee", casout={caslib="casuser", name="INSURANCE_CUSTOMER_DATA", replace=TRUE}; */
quit;

data CASUSER.INSURANCE_CUSTOMER_DATA; *copier la table de swee dans casuser et remplacer les codes régions pour pouvoir faire la jointure plus tard;
/* set SWEE.VHO_INSURANCE_CUSTOMER_DATA (drop=CUST_REGION_CD rename=(CUST_REGION_CD_MAP=CUST_REGION_CD)); */
set SWEE.UE_INSURANCE_CUSTOMER_DATA (drop=CUST_REGION_CD rename=(CUST_REGION_CD_MAP=CUST_REGION_CD));
if CUST_REGION_CD = 23 then CUST_REGION_CD = 24;
else if CUST_REGION_CD = 25 then CUST_REGION_CD = 27;
else if CUST_REGION_CD = 26 then CUST_REGION_CD = 28;
else if CUST_REGION_CD = 42 then CUST_REGION_CD = 44;
else if CUST_REGION_CD = 54 then CUST_REGION_CD = 75;
else if CUST_REGION_CD = 72 then CUST_REGION_CD = 76;
else if CUST_REGION_CD = 83 then CUST_REGION_CD = 84;
else if CUST_REGION_CD = 91 then CUST_REGION_CD = 75;
if VEH_FUEL_TYPE_CD = "Regular" then VEH_FUEL_TYPE_CD = "Essence";
RUN;


proc cas; *drop variable qui n'ont que des valeurs manquantes + ajouter des labels;
table.alterTable /
caslib="casuser"
columns={{label="Date de début de couverture", name="BEGIN_COV_DT"}
,{label="Date de fin de couverture", name="END_COV_DT"}
,{label="Date de l'annulation", name="CANCELLATION_DT"}
,{label="Client: code région", name="CUST_REGION_CD"}
,{label="Numéro de contrat", name="POLICY_ID"}
,{label="Exposition au risque", name="POLICY_EXPOSURE_AMT"}
,{label="Montant du sinistre", name="CLAIMS_AMT"}
,{label="Nombre de déclarations", name="CLAIMS_CNT"}
,{label="Catégorie de produit", name="LINE_OF_BUSINESS_ID"}
,{label="Couverture", name="COVERAGE_CD"}
,{label="Année", name="POLICY_UW_YEAR_NO"}
,{label="Indicateur de nouvelle politique", name="NEW_POLICY_FLG"}
,{label="Client: code zone", name="CUST_AREA_CD"}
,{label="Client: densité de population", name="CUST_POP_DENSITY_AMT"}
,{label="Client: age", name="CUST_AGE_AMT"}
,{label="Client: niveau bonus malus", name="CUST_BONUS_MALUS_LEVEL_AMT"}
,{label="Véhicule: type de carburant", name="VEH_FUEL_TYPE_CD"}
,{label="Véhicule: type", name="VEH_MAKE_MODEL_CD"}
,{label="Véhicule: age", name="VEH_AGE_AMT"}
,{label="Véhicule: puissance", name="VEH_POWER_LEVEL_AMT"}
/* ,{label="Gravité", name="Severity"} */
/* ,{label="Fréquence", name="Frequency"} */
}
name="INSURANCE_CUSTOMER_DATA"
;
quit; 

proc means data=CASUSER.INSURANCE_CUSTOMER_DATA n nmiss min max; run; *vérifier qu'il y a plus de valeurs manquantes;


proc cas; *promote;
table.promote / name="INSURANCE_CUSTOMER_DATA", caslib="casuser",  target="INSURANCE_CUSTOMER_DATA",  targetLib="casuser";
quit; 

/* cas mysession terminate;  */
/* cas mysession; */
/* caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com'; */
/* proc cas; */
/* table.save / caslib="yulia" name="INSURANCE_CUSTOMER_DATA"||".sashdat" table={name="INSURANCE_CUSTOMER_DATA", caslib="casuser"} replace=true; */
/* quit;  */
/* proc cas; */
/* table.deleteSource / caslib="yulia" source="INSURANCE_CUSTOMER_DATA"||".sashdat" ; */
/* quit;  */
