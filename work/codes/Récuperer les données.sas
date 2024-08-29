/* Récuperer les données */

libname swee cas caslib="swee";

%macro get_tables(tblname);

proc sql;
%if %sysfunc(exist(CASUSER.&tblname)) %then %do;
    drop table CASUSER.&tblname;
%end;
quit;

data  casuser.&tblname (promote=yes);
     set swee.yup_&tblname;
run;
%mend;

/* %get_tables(DONNEES_INSEE) */
%get_tables(ACCIDENTS_CORPORELS)
%get_tables(INSURANCE_CUSTOMER_DATA)


/* Récuperer les Flux */

filename flux "&_USERHOME/Viya_Experience.flw"; 

proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Viya_Experience.flw"
method="GET"
out=flux;
run;

filename flux clear;

filename flux "&_USERHOME/Viya_Experience_start.flw"; 

proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Viya_Experience_start.flw"
method="GET"
out=flux;
run;

filename flux clear; 