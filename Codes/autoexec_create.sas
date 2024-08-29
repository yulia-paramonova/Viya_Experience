cas casauto terminate;
cas mysession terminate;
cas mySession sessopts=(caslib=casuser timeout=1800 locale="en_US" metrics=true);

libname casuser cas caslib="casuser";
libname public cas caslib="public";
libname cafrance cas caslib="cafrance";

options casdatalimit=ALL;
