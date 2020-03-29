%LET root = /folders/myshortcuts/git;
%LET out = &root/sas-dev/Reindeer/out/;

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

ODS RTF FILE="&out/12_2_class.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
TITLE1 "Table 12.2: RTF Class output";
TITLE3 "with a sub title";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
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
TITLE "Table 15: RTF - Multi page cars output with PAGE grouping";
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
%loopTroughMake(Acura,16);
%loopTroughMake(Audi,17);
%loopTroughMake(BMW,18);
ODS TAGSETS.RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/18_2_class.rtf" STYLE=journal;
TITLE1 "Table 18.2: TAGSET RTF Class output with another subtitle";
TITLE3 "on a further title line";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
ODS TAGSETS.RTF CLOSE;

************* image outputs ****************;

ods listing gpath="&out";
ods graphics / 
	imagename="19_image" 
	imagefmt=jpg
	width=500px
  	height=300px;
PROC SGPLOT DATA = sashelp.class;
 	VBAR age / GROUP = sex;
 	TITLE 'Figure 1: Class overview by sex and age';
RUN; 

ods graphics / 
      width=2000px
      height=1000px
      outputfmt=gif
      imagename="20_width";
PROC SGPLOT DATA = sashelp.class;
 	VBAR age / GROUP = sex;
 	TITLE1 'Figure 2: Huge sized graphic';
 	TITLE2 'with titles in two lines';
RUN; 

ods graphics / 
      width=1000px
      height=2000px
      outputfmt=png
      imagename="21_height";
PROC SGPLOT DATA = sashelp.class;
 	VBAR age / GROUP = sex;
 	TITLE1 'Figure 3: Portrait graphic';
RUN;        

