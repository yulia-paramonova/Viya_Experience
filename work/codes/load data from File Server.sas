proc casutil;
	load file='/mnt/viya-share/data/github/viya_experience/Data/ACCIDENTS_CORPORELS.sashdat' 
		casout='ACCIDENTS_CORPORELS' outcaslib='casuser';
run;

proc casutil;
	load 
		file='/mnt/viya-share/data/github/viya_experience/Data/DONNEES_INSEE.sashdat' 
		casout='DONNEES_INSEE' outcaslib='casuser';
run;

proc casutil;
	load file='/mnt/viya-share/data/github/viya_experience/Data/table_VHO_CUSTOMER_DATA.csv' 
		casout='INSURANCE_CUSTOMER_DATA' outcaslib='casuser';
run;