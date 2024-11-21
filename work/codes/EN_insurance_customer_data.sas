/* Load tables from a caslib  */
proc cas;
mycaslib = "cafrance";
    table.fileinfo result=listfiles / caslib=mycaslib;
    do row over listfiles.fileinfo[1:listfiles.fileinfo.nrows];
        if (index(row.Name,'UE_')<>0) then do;
            datafile=row.Name;
            tablename=scan(row.Name,1);
            table.loadTable / casout={caslib=mycaslib name=tablename promote=true} caslib=mycaslib path=datafile;
        end;
    end;
quit;

data CASUSER.EN_INSURANCE_CUSTOMER_DATA; *copier la table de swee dans casuser et remplacer les codes régions pour pouvoir faire la jointure plus tard;
set CAFRANCE.UE_INSURANCE_CUSTOMER_DATA_DVR(drop=CUST_REGION_CD rename=(CUST_REGION_CD_MAP=CUST_REGION_CD));
if VEH_FUEL_TYPE_CD = "Essence" then VEH_FUEL_TYPE_CD = "Regular";
RUN;

proc cas; *add labels;
table.alterTable /
caslib="casuser"
columns=
{{label="Coverage Start Date", name="BEGIN_COV_DT"}
,{label="Coverage End Date", name="END_COV_DT"}
,{label="Policy Cancellation date", name="CANCELLATION_DT"}
,{label="Customer Region Code", name="CUST_REGION_CD"}
,{label="Policy Identifier", name="POLICY_ID"}
,{label="Policy Exposure Amount", name="POLICY_EXPOSURE_AMT"}
,{label="Claims Amount", name="CLAIMS_AMT"}
,{label="Claims Count", name="CLAIMS_CNT"}
,{label="Line of business", name="LINE_OF_BUSINESS_ID"}
,{label="Coverage Code", name="COVERAGE_CD"}
,{label="Year", name="POLICY_UW_YEAR_NO"}
,{label="New Policy Flag", name="NEW_POLICY_FLG"}
,{label="Customer Area Code", name="CUST_AREA_CD"}
,{label="Customer Population Density", name="CUST_POP_DENSITY_AMT"}
,{label="Customer Age", name="CUST_AGE_AMT"}
,{label="Customer Bonus-Malus Level", name="CUST_BONUS_MALUS_LEVEL_AMT"}
,{label="Vehicle Fuel Type Code", name="VEH_FUEL_TYPE_CD"}
,{label="Vehicle Make and Model Code", name="VEH_MAKE_MODEL_CD"}
,{label="Vehicle Age", name="VEH_AGE_AMT"}
,{label="Vehicle Power Level", name="VEH_POWER_LEVEL_AMT"}
}
name="EN_INSURANCE_CUSTOMER_DATA"
;
quit; 

libname mydata "/create-export/create/homes/Yulia.Paramonova@sas.com";

data mydata.EN_INSURANCE_CUSTOMER_DATA;
set CASUSER.EN_INSURANCE_CUSTOMER_DATA;
run;

/* cas mysession terminate;  */
/* cas mysession; */
caslib yulia datasource=(srctype="path") path='/create-export/create/homes/Yulia.Paramonova@sas.com';
proc cas;
table.save / caslib="yulia" name="EN_INSURANCE_CUSTOMER_DATA"||".sashdat" table={name="EN_INSURANCE_CUSTOMER_DATA", caslib="CASUSER"} replace=true;
quit; 
proc cas;
table.deleteSource / caslib="yulia" source="EN_INSURANCE_CUSTOMER_DATA"||".sashdat" ;
quit; 

proc cas;
	/* change to dvr the in memory tables */
	lib="casuser";
	table.fileInfo / caslib=lib;
	table.tableInfo result=rt / caslib=lib;
	tablelist=rt.tableInfo[, {"Name"}].where(Name contains "EN_");;


	do x over tablelist[1:tablelist.nrows];
*copy in dvr format;
		 table.copyTable / table={name=scan(x.name, 1) caslib=lib}
		    casOut={name=scan(x.name, 1)||"_DVR" caslib=lib memoryFormat="DVR" replace=True replication=0};
*save the dvr version of table;
		table.save / caslib=lib name=scan(x.name, 1)||"_DVR.sashdat" table={name=scan(x.name, 1)||"_DVR", caslib=lib} replace=true;
*promote the dvr version;
		*table.promote / name=scan(x.name, 1)||"_DVR", caslib=lib, target=scan(x.name, 1)||"_DVR", targetLib=lib;
*drop the non dvr version;
		*table.dropTable / caslib=lib, name=scan(x.name, 1), quiet=TRUE;
*delete the non dvr version;
		*table.deleteSource / caslib=lib source=scan(x.name, 1)||".sashdat" ;
	end;
	table.tableInfo / caslib=lib;
	table.fileInfo / caslib=lib;

quit;

proc cas;
table.save / caslib="yulia" name="EN_INSURANCE_CUSTOMER_DATA_DVR"||".sashdat" table={name="EN_INSURANCE_CUSTOMER_DATA_DVR", caslib="CASUSER"} replace=true;
quit; 
proc cas;
table.deleteSource / caslib="yulia" source="EN_INSURANCE_CUSTOMER_DATA_DVR"||".sashdat" ;
quit; 
