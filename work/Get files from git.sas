/* Données */

filename outfile "&_USERHOME/ACCIDENTS_CORPORELS.sashdat";
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

filename flux filename="&_USERHOME/hands_on_prepa.flw";

proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya-Hands-On/main/hands_on_prepa.flw"
method="GET"
out=flux;
run;

/* Etapes personnalisées */

filename outfile '&_USERHOME/Divers/Promote.step';
proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya-Hands-On/main/Etapes%20personnalis%C3%A9es/Promote.step"
method="GET"
out=outfile;
run;

filename outfile '&_USERHOME/Divers/Promote.step';
proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya-Hands-On/main/Etapes%20personnalis%C3%A9es/Promote.step"
method="GET"
out=outfile;
run;

filename outfile '&_USERHOME/Divers/Promote.step';
proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya-Hands-On/main/Etapes%20personnalis%C3%A9es/Promote.step"
method="GET"
out=outfile;
run;
