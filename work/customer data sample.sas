proc partition data=CAFRANCE.UE_INSURANCE_CUSTOMER_DATA samppct=20 seed=12345;
	output out=CAFRANCE.UE_INSURANCE_CUSTOMER_SAMPLE;
run;

proc cas; *promotes;
table.promote /
     name="UE_INSURANCE_CUSTOMER_SAMPLE",
     caslib="cafrance",
     target="UE_INSURANCE_CUSTOMER_SAMPLE",
     targetLib="cafrance";
quit; 


proc cas;
table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_SAMPLE"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_SAMPLE", caslib="cafrance"} replace=true;
quit; 

proc cas; 
lib="cafrance";
  table.copyTable /
    table={name="UE_INSURANCE_CUSTOMER_SAMPLE" caslib=lib}
    casOut={name="UE_INSURANCE_CUSTOMER_SAMPLE_dvr" caslib=lib memoryFormat="DVR" replace=True replication=0};
run;

proc cas;
table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR", caslib="cafrance"} replace=true;
quit; 

proc cas;
lib="cafrance";
	table.fileInfo / caslib=lib; *to see data source files;
	table.tableInfo / caslib=lib; *to see in-memory tables;
quit;

proc cas; 
lib="cafrance";
  table.copyTable /
    table={name="UE_INSURANCE_CUSTOMER_DATA" caslib=lib}
    casOut={name="UE_INSURANCE_CUSTOMER_DATA_DVR" caslib=lib memoryFormat="DVR" replace=True replication=0};
table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_DATA_DVR"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_DATA_DVR", caslib="cafrance"} replace=true;
run;

proc cas;
lib="cafrance";
	table.fileInfo / caslib=lib; *to see data source files;
	table.tableInfo / caslib=lib; *to see in-memory tables;
quit;

proc cas;
table.save / caslib="cafrance" name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR"||".sashdat" table={name="UE_INSURANCE_CUSTOMER_SAMPLE_DVR", caslib="cafrance"} replace=true;
quit; 

/* proc cas; */
/* table.deleteSource / caslib="yulia" source="UE_INSURANCE_CUSTOMER_SAMPLE"||".sashdat" ; */
/* quit;  */

%put _all_;