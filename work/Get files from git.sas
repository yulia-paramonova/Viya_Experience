/* Données */

filename outfile "&_USERHOME/ACCIDENTS_CORPORELS_testgit.sashdat";
proc http
/* url="https://raw.githubusercontent.com/yulia-paramonova/Viya-Hands-On/main/Data/table_VHO_ACCIDENTS_CORPORELS.csv" */
url="https://github.com/yulia-paramonova/Viya-Hands-On/raw/main/Data/ACCIDENTS_CORPORELS.sashdat"
method="GET"
out=outfile;
run;

proc casutil;
	load file="&_USERHOME/ACCIDENTS_CORPORELS.sashdat"
		promote casout='ACCIDENTS_CORPORELS_testgit' outcaslib='casuser';
run;

/* Flux */

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
