cas mysession sessopts=(caslib=casuser timeout=1800 locale="en_US" metrics=true);

libname casuser cas caslib="casuser";
libname public cas caslib="public";

options casdatalimit=ALL;
