/* Données */

/* UE_INSURANCE_CUSTOMER_DATA_DVR */

filename outfile "&_USERHOME/UE_INSURANCE_CUSTOMER_DATA_DVR.zip";
proc http
url="https://github.com/yulia-paramonova/Viya_Experience/tree/main/Donn%C3%A9es/UE_INSURANCE_CUSTOMER_DATA_DVR.zip"
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
url="https://github.com/yulia-paramonova/Viya_Experience/tree/main/Donn%C3%A9es/UE_OPENDATA_ACCIDENT.sashdat"
method="GET"
out=outfile2;
run;

proc casutil;
	load file="&_USERHOME/UE_OPENDATA_ACCIDENT.sashdat"
		promote casout='UE_OPENDATA_ACCIDENT' outcaslib='casuser';
run;

/* Flux */

filename flux "&_USERHOME/Viya_Experience.flw"; 

proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Flux/Viya_Experience.flw"
method="GET"
out=flux;
run;

filename flux clear;

/* Etapes personnalisées */

/* filename outfile filesrvc folderpath="/Public" filename='Promote.step'; */
filename outfile filesrvc folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder" filename='Promote.step';
/* filename outfile "&_USERHOME/Divers/Promote.step"; */
proc http
url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Promote.step'
method="GET"
out=outfile;
run;
filename outfile clear;

/* filename outfile filesrvc folderpath="/Public" filename='Remplacer les valeurs manquantes par 0.step'; */
filename outfile filesrvc folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder" filename='Remplacer les valeurs manquantes par 0.step';
/* filename outfile "&_USERHOME/Divers/Remplacer les valeurs manquantes par 0.step"; */
proc http
url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Remplacer%20les%20valeurs%20manquantes%20par%200.step'
method="GET"
out=outfile;
run;
filename outfile clear;

/* filename outfile filesrvc folderpath="/Public" filename='Call_Api.step'; */
filename outfile filesrvc folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder" filename='Call_Api.step';
/* filename outfile "&_USERHOME/Divers/Call_Api.step"; */
proc http
url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Call_Api.step'
method="GET"
out=outfile;
run;
filename outfile clear;
