cas casauto terminate;
cas mysession terminate;
cas mySession sessopts=(caslib=casuser timeout=1800 locale="en_US" metrics=true);

libname casuser cas caslib="casuser";
libname public cas caslib="public";
libname swee cas caslib="swee";

options casdatalimit=ALL;

filename flux "&_USERHOME/Viya_Experience.flw"; 
proc http
url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Viya_Experience.flw"
method="GET"
out=flux;
run;
filename flux clear;
