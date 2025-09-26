/* PREPARER LES DONNES INTERNES */

data casuser.customer_prep;
    set cafrance.UE_INSURANCE_CUSTOMER_DATA_DVR (drop=BEGIN_COV_DT END_COV_DT CANCELLATION_DT);
run; 

/* Prepare open data */

/* Remplacer les valeurs manquantes de toutes les variables numeriques par 0. */
data CASUSER.OPENDATA_prep;
   set cafrance.UE_OPENDATA_ACCIDENT;
   array change _numeric_;
        do over change;
            if change=. then change=0;
    end;
 run ;

/* AGREGER AU NIVEAU REGION */

/* Supprimer la table WORK.OPENDATA_PREP */
proc datasets library = WORK memtype = (data view) nolist nowarn;
   delete OPENDATA_PREP;
quit;

/* Requete pour regrouper les données par Région */
/* La somme pour la Population et Nombre d'accidents et la moyenne pour le reste */
PROC SQL;
   CREATE TABLE WORK.OPENDATA_PREP AS
   SELECT 
      t1.'Code Région'n LABEL='Code Région' AS CODE_REGION,
      MEAN(t1.Altitude) LABEL='Altitude Moyenne' LENGTH=8 AS MEAN_Altitude,
      SUM(t1.Population) LABEL='Population' LENGTH=8 AS SUM_Population,
      SUM(t1.'Nombre d''accident'n) LABEL='Nombre d''accident' LENGTH=8 AS 'SUM_Nb_accident'n,
      MEAN(t1.'Vitesses maximales'n) LABEL='Moyenne des Vitesses maximales' LENGTH=8 AS 'MEAN_Vitesses_maximales'n,
      MEAN(t1.'Largeur TP central'n) LABEL='Moyenne Largeur terre-plein central' LENGTH=8 AS 'MEAN_Largeur_TP_central'n,
      MEAN(t1.'Largeur chaussée'n) LABEL='Moyenne Largeur chaussée' LENGTH=8 AS 'MEAN_Largeur_chaussée'n
   FROM
      CASUSER.OPENDATA_PREP t1

   GROUP BY
      t1.'Code Région'n
   ;
QUIT;
RUN;

/* Supprimer la table CASUSER.OPENDATA_PREP */
proc datasets library = CASUSER memtype = (data view) nolist nowarn;
   delete OPENDATA_PREP;
quit;

/* Promouvoir la table dans CASUSER */
data CASUSER.OPENDATA_prep (promote=yes);
   set WORK.OPENDATA_PREP;
run; 

/* Joindre les tables pour créer la table finale pour prédire le nombre de sinistres par conducteur */

proc fedsql sessref=ss;
    create table casuser.data_for_ml as
    SELECT 
      t1.*,
      t2.*  
    from       CASUSER.CUSTOMER_PREP as t1
         left join CASUSER.OPENDATA_PREP as t2 ON (t1.CUST_REGION_CD_MAP = t2.CODE_REGION)
   ;
quit;
run;

proc datasets library = CASUSER memtype = (data view) nolist nowarn;
   delete OPENDATA_PREP customer_prep;
quit;
