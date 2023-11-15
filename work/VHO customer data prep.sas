proc cas;
table.dropTable /caslib="casuser", name="VHO_INSURANCE_CUSTOMER_DATA" quiet=TRUE;
table.loadTable / path="VHO_INSURANCE_CUSTOMER_DATA.sashdat", caslib="swee", casout={caslib="casuser", name="INSURANCE_CUSTOMER_DATA", replace=TRUE};
quit;

proc cas;
table.alterTable /
caslib="casuser"
columns={{label="Date de début de couverture", name="BEGIN_COV_DT"},
{label="Date de fin de couverture", name="END_COV_DT"},
{label="Montant du risque sur la police d'assurance", name="POLICY_EXPOSURE_AMT"},
{label="Idéntifiant de la ligne de business", name="LINE_OF_BUSINESS_ID"},
{label="Couverture", name="COVERAGE_CD"},
{label="Police d'assurance année", name="POLICY_UW_YEAR_NO"},
{label="Date de l'annulation", name="CANCELLATION_DT"},
{label="Indicateur de nouvelle politique", name="NEW_POLICY_FLG"},
{label="Client: code de la zone", name="CUST_AREA_CD"},
{label="Client: code du région", name="CUST_REGION_CD"},
{label="Client: densité de population", name="CUST_POP_DENSITY_AMT"},
{label="Client: age", name="CUST_AGE_AMT"},
{label="Client: niveau bonus malus", name="CUST_BONUS_MALUS_LEVEL_AMT"},
{label="Véhicule: type d'essence", name="VEH_FUEL_TYPE_CD"},
{label="Véhicule: marque et modèle", name="VEH_MAKE_MODEL_CD"},
{label="Véhicule: age", name="VEH_AGE_AMT"},
{label="Véhicule: puissance", name="VEH_POWER_LEVEL_AMT"},
{label="Numéro de la police d'assurance", name="Policy number"},
{label="Gravité", name="Severity"},
{label="Fréquence", name="Frequency"}}
name="INSURANCE_CUSTOMER_DATA"
;
quit; 

proc cas;
table.promote / name="INSURANCE_CUSTOMER_DATA", caslib="casuser",  target="INSURANCE_CUSTOMER_DATA",  targetLib="casuser";
quit; 

cas mysession terminate; 
cas mysession;
caslib yulia datasource=(srctype="path") path='/greenmonthly-export/ssemonthly/homes/Yulia.Paramonova@sas.com';

proc cas;
table.save / caslib="yulia" name="INSURANCE_CUSTOMER_DATA"||".sashdat" table={name="INSURANCE_CUSTOMER_DATA", caslib="casuser"} replace=true;
quit; 

proc means data=CASUSER.INSURANCE_CUSTOMER_DATA n nmiss min max; run; 