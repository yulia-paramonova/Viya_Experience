/* Données */

/* UE_INSURANCE_CUSTOMER_DATA_DVR */

filename outfile "&_USERHOME/UE_INSURANCE_CUSTOMER_DATA_DVR.zip";
proc http
url="https://github.com/yulia-paramonova/Viya_Experience/raw/main/Data/UE_INSURANCE_CUSTOMER_DATA_DVR.zip"
method="GET"
out=outfile;
run;


filename inzip zip "&_USERHOME/UE_INSURANCE_CUSTOMER_DATA_DVR.zip";

data _null_;
    infile inzip(UE_INSURANCE_CUSTOMER_DATA_DVR.sashdat) lrecl=256 recfm=F length=length eof=eof unbuf;
    file "&_USERHOME/UE_INSURANCE_CUSTOMER_DATA_DVR.sashdat" lrecl=256 recfm=N;
    input;
    put _infile_;
    return;
    eof:
    stop;
run;

proc casutil;
	load file="&_USERHOME/UE_INSURANCE_CUSTOMER_DATA_DVR.sashdat"
		promote casout='UE_INSURANCE_CUSTOMER_DATA_DVR' outcaslib='casuser';
run;


/* UE_OPENDATA_ACCIDENT */

filename outfile2 "&_USERHOME/UE_OPENDATA_ACCIDENT.sashdat";
proc http
url="https://github.com/yulia-paramonova/Viya_Experience/raw/main/Data/UE_OPENDATA_ACCIDENT.sashdat"
method="GET"
out=outfile2;
run;

proc casutil;
	load file="&_USERHOME/UE_OPENDATA_ACCIDENT.sashdat"
		promote casout='UE_OPENDATA_ACCIDENT' outcaslib='casuser';
run;
