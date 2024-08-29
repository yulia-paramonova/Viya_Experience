libname swee cas caslib="swee";

proc cas;
table.dropTable /caslib="swee", name="yup_donnees_insee" quiet=TRUE;
table.promote / name="donnees_insee", caslib="casuser",  target="yup_donnees_insee",  targetLib="swee";
quit; 

proc cas;
table.dropTable /caslib="swee", name="YUP_ACCIDENTS_CORPORELS" quiet=TRUE;
table.promote / name="ACCIDENTS_CORPORELS", caslib="casuser",  target="YUP_ACCIDENTS_CORPORELS",  targetLib="swee";
quit; 

proc cas;
table.dropTable /caslib="swee", name="YUP_INSURANCE_CUSTOMER_DATA" quiet=TRUE;
table.promote / name="INSURANCE_CUSTOMER_DATA", caslib="casuser",  target="YUP_INSURANCE_CUSTOMER_DATA",  targetLib="swee";
quit; 

proc cas;
table.dropTable /caslib="swee", name="YUP_OPENDATA" quiet=TRUE;
table.promote / name="OPENDATA", caslib="casuser",  target="YUP_OPENDATA",  targetLib="swee";
quit; 

proc cas;
table.dropTable /caslib="swee", name="YUP_ABT" quiet=TRUE;
table.promote / name="ABT", caslib="casuser",  target="YUP_ABT",  targetLib="swee";
quit; 

data swee.YUP_ACCIDENTS_CORPORELS (promote=yes);
set CASUSER.ACCIDENTS_CORPORELS; 
run; 

data swee.YUP_CUSTOMER_DATA_PREPARED (promote=yes);
set CASUSER.CUSTOMER_DATA_PREPARED; 
run; 


data swee.YUP_DONNEES_INSEE (promote=yes);
set CASUSER.DONNEES_INSEE; 
run; 

data swee.YUP_INSURANCE_CUSTOMER_DATA (promote=yes);
set CASUSER.INSURANCE_CUSTOMER_DATA; 
run; 

data swee.YUP_OPENDATA (promote=yes);
set CASUSER.OPENDATA; 
run; 