libname cafrance cas caslib="cafrance";
proc cas;
lib="cafrance";
    table.fileInfo / caslib=lib; *to see data source files;
	table.tableInfo / caslib=lib; *to see in-memory tables;
quit;

proc casutil;
load casdata='UE_INSURANCE_CUSTOMER_DATA_DVR.sashdat' casout='UE_INSURANCE_CUSTOMER_DATA_DVR' incaslib='cafrance' outcaslib='cafrance';
promote CASDATA='UE_INSURANCE_CUSTOMER_DATA_DVR' incaslib='cafrance' OUTCASLIB='cafrance';
load casdata='UE_OPENDATA_ACCIDENT.sashdat' casout='UE_OPENDATA_ACCIDENT' incaslib='cafrance' outcaslib='cafrance';
promote CASDATA='UE_OPENDATA_ACCIDENT' incaslib='cafrance' OUTCASLIB='cafrance';
quit; 
