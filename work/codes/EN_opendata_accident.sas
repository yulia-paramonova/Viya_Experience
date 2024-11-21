/* Load tables from a caslib  */
proc cas;
mycaslib = "cafrance";
    table.fileinfo result=listfiles / caslib=mycaslib;
    do row over listfiles.fileinfo[1:listfiles.fileinfo.nrows];
        if (index(row.Name,'UE_')<>0) then do;
            datafile=row.Name;
            tablename=scan(row.Name,1);
            table.loadTable / casout={caslib=mycaslib name=tablename promote=true} caslib=mycaslib path=datafile;
        end;
    end;
quit;

data CASUSER.EN_OPENDATA_ACCIDENT; *copier la table de swee dans casuser et remplacer les codes régions pour pouvoir faire la jointure plus tard;
set CAFRANCE.UE_OPENDATA_ACCIDENT (drop='Département'n);
RUN;

proc cas; *add labels;
table.alterTable /
caslib="casuser"
columns=
{{label="Region Code", name="Code Région", rename="Region Code"}
,{label="Department Code", name="Code Département", rename="Department Code"}
,{label="Average Altitude", name="Altitude", rename="Altitude"}
,{label="Population", name="Population", rename="Population"}
,{label="Department", name="Département", rename="Department"}
,{label="Number of Accidents", name="Nombre d'accident", rename="Number of Accidents"}
,{label="Average Maximum Speeds", name="Vitesses maximales", rename="Maximum Speeds"}
,{label="Average Central Median Width", name="Largeur TP central", rename="Central Median Width"}
,{label="Average Roadway Width", name="Largeur chaussée", rename="Roadway Width"}
}
name="EN_OPENDATA_ACCIDENT"
;
quit; 

/* cas mysession terminate;  */
/* cas mysession; */
caslib yulia datasource=(srctype="path") path='/create-export/create/homes/Yulia.Paramonova@sas.com';
proc cas;
table.save / caslib="yulia" name="EN_OPENDATA_ACCIDENT"||".sashdat" table={name="EN_OPENDATA_ACCIDENT", caslib="CASUSER"} replace=true;
quit; 
proc cas;
table.deleteSource / caslib="yulia" source="EN_OPENDATA_ACCIDENT"||".sashdat" ;
quit; 








