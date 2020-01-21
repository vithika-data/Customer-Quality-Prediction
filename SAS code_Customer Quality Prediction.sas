/* Reading the data*/
    data WORK.a1    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'C:\Users\vxa180017\Desktop\training.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat custAge $2. ;
       informat profession $14. ;
       informat marital $10. ;
       informat schooling $21. ;
       informat default $9. ;
       informat housing $5. ;
       informat loan $5. ;
       informat contact $11. ;
       informat month $5. ;
       informat day_of_week $5. ;
       informat campaign best32. ;
       informat pdays best32. ;
       informat previous best32. ;
       informat poutcome $13. ;
       informat emp_var_rate best32. ;
       informat cons_price_idx best32. ;
       informat cons_conf_idx best32. ;
       informat euribor3m best32. ;
       informat nr_employed best32. ;
       informat pmonths best32. ;
       informat pastEmail best32. ;
       informat responded $4. ;
       informat profit $2. ;
       informat id best32. ;
       format custAge $2. ;
       format profession $14. ;
       format marital $10. ;
       format schooling $21. ;
       format default $9. ;
       format housing $5. ;
       format loan $5. ;
       format contact $11. ;
       format month $5. ;
       format day_of_week $5. ;
       format campaign best12. ;
       format pdays best12. ;
       format previous best12. ;
       format poutcome $13. ;
       format emp_var_rate best12. ;
       format cons_price_idx best12. ;
       format cons_conf_idx best12. ;
       format euribor3m best12. ;
       format nr_employed best12. ;
       format pmonths best12. ;
       format pastEmail best12. ;
       format responded $4. ;
       format profit $2. ;
       format id best12. ;
    input
                custAge  $
                profession  $
                marital  $
                schooling  $
                default  $
                housing  $
                loan  $
                contact  $
                month  $
                day_of_week  $
                campaign
                pdays
                previous
                poutcome  $
                emp_var_rate
                cons_price_idx
                cons_conf_idx
                euribor3m
                nr_employed
                pmonths
                pastEmail
                responded  $
                profit  $
                id
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;
/*Basic data imputation in SAS*/
data a2;set a1;
if contact="cellular" then cell=1; else cell=0;
if 18 < custage <=27 then age1=1;else age1=0;
if 27 < custage <=38 then age2=1;else age2=0;
if 38 < custage <=60 then age3=1;else age3=0;
if 38 < custage <=60 then age4=1;else age4=0;
if day_of_week="mon" then mon=1;else mon=0;
if day_of_week="tue" then tue=1;else tue=0;
if day_of_week="wed" then wed=1;else wed=0;
if day_of_week="thu" then thu=1;else thu=0;
if day_of_week="fri" then fri=1;else fri=0;
if day_of_week="NA" then downa=1;else dawna=0;
if housing='yes' then hsg=1;else hsg=0;
if loan="yes" then ln=1;else ln=0;
if marital = "married" then marr =1;else marr=0;
if marital = "single" then sing =1;else sing=0;
if month="mar" then mar=1;else mar=0;
if month="apr" then apr=1;else apr=0;
if month="may" then may=1;else may=0;
if month="jun" then jun=1;else jun=0;
if month="jul" then jul=1;else jul=0;
if month="aug" then aug=1;else aug=0;
if month="sep" then sep=1;else sep=0;
if month="oct" then oct=1;else oct=0;
if schooling="basic.4y" or schooling="basic.6y" or schooling="basic.9y" or schooling="illiterate" then edu1=1;else edu1=0;
if schooling="high.school" then edu2=1;else edu2=0;
if schooling="professional.course" then edu3=1;else edu3=0;
if schooling="university.degree" then edu4=1;else edu4=0;
if schooling="NA" or schooling="NA" then edu=1;else edu=0;
run;
/*Running Logistic Model on categorical Variables*/
proc logistic;
model responded (event="yes")= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu;run;
proc corr;var pdays pmonths;run;
/*Running Logistic Model on both Continuous and Categorical Variables*/
proc logistic;
model responded (event="yes")= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail
;run;
proc corr;var cons_price_idx cons_conf_idx;run;
/*Running Regression on Profit Variable*/
proc reg;
model profit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail
;run;
data a3;set a2;
nprofit=profit*1.;run;
proc reg;
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail
;run;
proc reg plots=none;
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail/vif stb
;run;
data a3;set a2;
nprofit=log(profit*1.);run;
/*Transforming profit variable and then predicting it - not required since profit is normally distributed*/
proc reg plots=none;
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail/vif stb
;run;
data a3;set a2;
nprofit=log(profit*1.);
pmsq=pmonths*pmonths;
run;

proc reg plots=none;
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pmsq pastEmail/vif stb
;run;
proc reg plots=none;
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pdays pastEmail/vif stb
;run;
proc reg plots=none;
model nprofit=  ln /stb
;run;
proc reg plots=none;
model nprofit=  ln campaign/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign pmonths/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign pdays/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age4/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4 hsg/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4 cell/stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4 /vif stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4 cons_price_idx/vif stb
;run;
proc reg plots=none;
model nprofit=  ln campaign age3 age4 cons_conf_idx/vif stb
;run;
proc contents;run;
proc means;run;
proc freq;table contact custAge day_of_week default housing loan marital month poutcome profession profit responded schooling;run;

data a2;set a1;
if contact="cellular" then cell=1; else cell=0;
if custage gt 18 and custage le 27 then age1=1;else age1=0;
if custage gt 27 and custage le 38 then age2=1;else age2=0;
if custage gt 38 and custage le 60 then age3=1;else age3=0;
if custage gt 60 then age4=1;else age4=0;

if day_of_week="mon" then mon=1;else mon=0;
if day_of_week="tue" then tue=1;else tue=0;
if day_of_week="wed" then wed=1;else wed=0;
if day_of_week="thu" then thu=1;else thu=0;
if day_of_week="fri" then fri=1;else fri=0;
if day_of_week="NA" then downa=1;else downa=0;
if housing='yes' then hsg=1;else hsg=0;
if loan="yes" then ln=1;else ln=0;
if marital = "married" then marr =1;else marr=0;
if marital = "single" then sing =1;else sing=0;
if month="mar" then mar=1;else mar=0;
if month="apr" then apr=1;else apr=0;
if month="may" then may=1;else may=0;
if month="jun" then jun=1;else jun=0;
if month="jul" then jul=1;else jul=0;
if month="aug" then aug=1;else aug=0;
if month="sep" then sep=1;else sep=0;
if month="oct" then oct=1;else oct=0;

if schooling="basic.4y" or schooling="basic.6y" or schooling="basic.9y" or schooling="illiterate" then edu1=1;else edu1=0;
if schooling="high.school" then edu2=1;else edu2=0;
if schooling="professional.course" then edu3=1;else edu3=0;
if schooling="university.degree" then edu4=1;else edu4=0;
if schooling="NA" or schooling="NA" then edu=1;else edu=0;
run;

proc corr;var pdays pmonths;run;
proc corr;var cons_price_idx cons_conf_idx;run;

proc logistic; 
model responded (event="yes")= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu 
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pastEmail
;run;

data a3;set a2;
nprofit=log(profit*1.);
pmsq=pmonths*pmonths;
run;

proc reg plots=none; 
model nprofit= cell age2 age3 age4 mon tue wed thu downa hsg ln marr sing mar apr may jun jul aug sep oct edu2 edu3 edu4 edu 
campaign previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed pmonths pdays pastEmail/vif stb
;run;

proc reg plots=none; 
model nprofit=  ln campaign age3 age4 cons_conf_idx/vif stb
;run;
