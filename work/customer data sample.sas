/*  Créer le sample */
/* proc partition data=CAFRANCE.UE_INSURANCE_CUSTOMER_DATA samppct=20 seed=12345; */
/* 	output out=CAFRANCE.UE_INSURANCE_CUSTOMER_SAMPLE; */
/* run; */
/*  */
/* proc cas; *promote la table sample; */
/* table.promote / name="UE_INSURANCE_CUSTOMER_SAMPLE", caslib="cafrance", target="UE_INSURANCE_CUSTOMER_SAMPLE", targetLib="cafrance"; */
/* quit;  */
/*  */
/* proc cas; *save la table sample; */
/* table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_SAMPLE"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_SAMPLE", caslib="cafrance"} replace=true; */
/* quit;  */
/*  */
/* proc cas; *changer le format de la table sample en DVR; */
/* lib="cafrance"; */
/*   table.copyTable / */
/*     table={name="UE_INSURANCE_CUSTOMER_SAMPLE" caslib=lib} */
/*     casOut={name="UE_INSURANCE_CUSTOMER_SAMPLE_dvr" caslib=lib memoryFormat="DVR" replace=True replication=0}; */
/* run; */
/*  */
/* proc cas; *save la table sample dvr dans cafrance; */
/* table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR", caslib="cafrance"} replace=true; */
/* quit;  */
/*  */
/* proc cas; *check la taille de la table dvr; */
/* lib="cafrance"; */
/* 	table.fileInfo / caslib=lib; *to see data source files; */
/* 	table.tableInfo / caslib=lib; *to see in-memory tables; */
/* quit; */

proc cas; *changer le format de la table complete en DVR;
lib="cafrance";
  table.copyTable /
    table={name="UE_INSURANCE_CUSTOMER_DATA" caslib=lib}
    casOut={name="UE_INSURANCE_CUSTOMER_DATA_DVR" caslib="casuser" memoryFormat="DVR" replace=True replication=0};
run;

proc cas; *save la table complete dvr dans CASUSER pour télécharger après (Home/casuser/UE_INSURANCE_CUSTOMER_DATA_DVR.sashdat);
lib="casuser";
table.save / caslib=lib name="UE_INSURANCE_CUSTOMER_DATA_DVR"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_DATA_DVR", caslib=lib} replace=true;
run;

proc cas; *promote la table sample dans cafrance;
table.promote / name="UE_INSURANCE_CUSTOMER_DATA_DVR", caslib="casuser", target="UE_INSURANCE_CUSTOMER_DATA_DVR", targetLib="cafrance";
quit; 

proc cas; *check la taille de la table dvr;
lib="cafrance";
	table.fileInfo / caslib=lib; *to see data source files;
	table.tableInfo / caslib=lib; *to see in-memory tables;
quit;

proc cas;
table.deleteSource / 
caslib="cafrance" 
source="UE_INSURANCE_CUSTOMER_SAMPLE"||".sashdat" ;
quit; 

proc cas;
table.deleteSource / 
caslib="cafrance" 
source="UE_INSURANCE_CUSTOMER_SAMPLE_DVR"||".sashdat" ;
quit; 

