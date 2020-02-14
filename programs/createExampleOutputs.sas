%LET root = /folders/myshortcuts/git;
%LET out = &root/sas-dev/ResultRenderer/out/;

OPTIONS NODATE NONUMBER NOCENTER;
TITLE;FOOTNOTE;
ODS LISTING;
OPTIONS PS=35;

************* outputs ****************;

PROC PRINTTO PRINT="&out/01_class.lst" NEW; RUN;
TITLE "Table 1: Simple Class Output";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
PROC PRINTTO;RUN;


PROC PRINTTO PRINT="&out/02_cars.lst" NEW; RUN;
TITLE "Table 2: Multi page cars output";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
RUN;
TITLE;FOOTNOTE;
PROC PRINTTO;RUN;

PROC PRINTTO PRINT="&out/03_cars_page.lst" NEW; RUN;
TITLE "Table 3: Multi page cars output with PAGE grouping";
TITLE2 "and multiple heading lines";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
	BY make;
	DEFINE make / ORDER NOPRINT;
	BREAK AFTER make / PAGE;
RUN;
TITLE;FOOTNOTE;
PROC PRINTTO;RUN;

%MACRO loopTroughMake(make,i);
	TITLE "Table &i: Multiple outputs in one File - Cars for make = &make";
	TITLE2 "with multiple titles.";
	PROC REPORT DATA=sashelp.cars(WHERE=(make = "&make")) nowd headline spacing=2;
		COLUMN make model type msrp;
	RUN;
	TITLE;
%MEND;

PROC PRINTTO PRINT="&out/04_cars_multioutput.lst" NEW; RUN;
%loopTroughMake(Acura,4);
%loopTroughMake(Audi,5);
%loopTroughMake(BMW,6);
PROC PRINTTO;RUN;

************* ODS RTF outputs ****************;

ODS RTF FILE="&out/07_class.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
TITLE "Table 7: RTF Class output";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
ODS RTF CLOSE;


ODS RTF FILE="&out/08_cars.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
TITLE "Table 8: RTF - Multi page cars output";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
RUN;
TITLE;FOOTNOTE;
ODS RTF CLOSE;

ODS RTF FILE="&out/09_cars.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
TITLE "Table 9: RTF - Multi page cars output with PAGE grouping";
TITLE2 "and multiple heading lines";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
	BY make;
	DEFINE make / ORDER NOPRINT;
	BREAK AFTER make / PAGE;
RUN;
TITLE;FOOTNOTE;
ODS RTF CLOSE;


ODS RTF FILE="&out/10_12_cars.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
%loopTroughMake(Acura,10);
%loopTroughMake(Audi,11);
%loopTroughMake(BMW,12);
ODS RTF CLOSE;

************* ODS TAGSET RTF outputs ****************;

ODS TAGSETS.RTF FILE="&out/13_class.rtf" STYLE=journal;
TITLE "Table 13: TAGSET RTF Class output";
FOOTNOTE "with a footnote";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
ODS TAGSETS.RTF CLOSE;


ODS TAGSETS.RTF FILE="&out/14_cars.rtf" STYLE=journal;
TITLE "Table 14: RTF - Multi page cars output";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
RUN;
TITLE;FOOTNOTE;
ODS TAGSETS.RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/15_cars.rtf" STYLE=journal;
TITLE "Table 9: RTF - Multi page cars output with PAGE grouping";
TITLE2 "and multiple heading lines";
FOOTNOTE1 "Created as example.";
FOOTNOTE2 "This includes footnotes.";
PROC REPORT DATA=sashelp.cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
	COLUMN make model type msrp;
	BY make;
	DEFINE make / ORDER NOPRINT;
	BREAK AFTER make / PAGE;
RUN;
TITLE;FOOTNOTE;
ODS TAGSETS.RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/16_18_cars.rtf" STYLE=journal;
%loopTroughMake(Acura,10);
%loopTroughMake(Audi,11);
%loopTroughMake(BMW,12);
ODS TAGSETS.RTF CLOSE;

************* image outputs ****************;

ods listing gpath="&out";
ods graphics / imagename="13_image" imagefmt=jpg;
PROC SGPLOT DATA = sashelp.class;
 	VBAR age / GROUP = sex;
 	TITLE 'Figure 1: Class overview by sex and age';
RUN; 

