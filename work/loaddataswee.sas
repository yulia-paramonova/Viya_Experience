libname swee cas caslib="swee";
proc cas;
lib="swee";
    table.fileInfo / caslib=lib; *to see data source files;
	table.tableInfo / caslib=lib; *to see in-memory tables;
quit;

proc casutil;
load casdata='UE_INSURANCE_CUSTOMER_DATA.sashdat' casout='UE_INSURANCE_CUSTOMER_DATA' incaslib='swee' outcaslib='casuser';
promote CASDATA='UE_INSURANCE_CUSTOMER_DATA' incaslib='casuser' OUTCASLIB='casuser';
load casdata='UE_OPENDATA_ACCIDENT.sashdat' casout='UE_OPENDATA_ACCIDENT' incaslib='swee' outcaslib='casuser';
promote CASDATA='UE_OPENDATA_ACCIDENT' incaslib='casuser' OUTCASLIB='casuser';
quit; 
