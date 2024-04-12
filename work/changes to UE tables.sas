data CASUSER.INSURANCE_CUSTOMER_DATA; *copier la table de swee dans casuser et remplacer les codes régions pour pouvoir faire la jointure plus tard;
set swee.UE_INSURANCE_CUSTOMER_DATA ;
if CUST_REGION_CD_MAP = 23 then CUST_REGION_CD_MAP = 24;
else if CUST_REGION_CD_MAP = 25 then CUST_REGION_CD_MAP = 27;
else if CUST_REGION_CD_MAP = 26 then CUST_REGION_CD_MAP = 28;
else if CUST_REGION_CD_MAP = 42 then CUST_REGION_CD_MAP = 44;
else if CUST_REGION_CD_MAP = 54 then CUST_REGION_CD_MAP = 75;
else if CUST_REGION_CD_MAP = 72 then CUST_REGION_CD_MAP = 76;
else if CUST_REGION_CD_MAP = 83 then CUST_REGION_CD_MAP = 84;
else if CUST_REGION_CD_MAP = 91 then CUST_REGION_CD_MAP = 75;
if VEH_FUEL_TYPE_CD = "Regular" then VEH_FUEL_TYPE_CD = "Essence";
RUN;

data casuser.OPENDATA_ACCIDENT; * créer des valeurs manquantes;
set swee.ue_OPENDATA_ACCIDENT;
if 'Largeur chaussée'n <= 1 then 'Largeur chaussée'n=.;
if 'Largeur TP central'n < 1 then 'Largeur TP central'n=.;
run; 


caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com';
proc cas;
table.save / caslib="yulia" name="INSURANCE_CUSTOMER_DATA"||".sashdat" table={name="INSURANCE_CUSTOMER_DATA", caslib="casuser"} replace=true;
quit; 
proc cas;
table.save / caslib="yulia" name="OPENDATA_ACCIDENT"||".sashdat" table={name="OPENDATA_ACCIDENT", caslib="casuser"} replace=true;
quit; 
proc cas;
table.deleteSource / caslib="yulia" source="OPENDATA_ACCIDENT"||".sashdat" ;
quit; 
proc cas;
table.deleteSource / caslib="yulia" source="INSURANCE_CUSTOMER_DATA"||".sashdat" ;
quit; 