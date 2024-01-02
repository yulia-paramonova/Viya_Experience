cas mysession sessopts=(caslib=casuser timeout=1800 locale="en_US" metrics=true);

libname casuser cas caslib="casuser";
libname public cas caslib="public";

options casdatalimit=ALL;

filename flux "&_USERHOME/Viya_Experience.flw"; 
%macro check(dir= ) ;
%if %sysfunc(fileexist(&dir)) %then %do; %put File Exists ; %end;
%else %do ; 
%put File doesn’t exist.;
	proc http
	url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Viya_Experience.flw"
	method="GET" out=flux; run;
%end ;
%mend ;
%check(dir="&_USERHOME/Viya_Experience.flw");
filename flux clear;
