%LET root = /folders/myshortcuts/git;
%LET out = &root/reindeer/out/;

OPTIONS DATE NONUMBER NOCENTER ORIENTATION=landscape;
TITLE;FOOTNOTE;
ODS LISTING;
ODS ESCAPECHAR="^";
OPTIONS PS=35;

%************ examples using no BODYTITLE *********************************;

%MACRO loopTroughMake(make,i);
	TITLE "Table &i: Multiple outputs in one File - Cars for make = &make";
	TITLE2 "with multiple titles.";
	PROC REPORT DATA=sashelp.cars(WHERE=(make = "&make")) nowd headline spacing=2;
		COLUMN make model type msrp;
	RUN;
	TITLE;
%MEND;

ODS TAGSETS.RTF FILE="&out/100_cars.rtf" STYLE=journal;
%loopTroughMake(Acura,100);
%loopTroughMake(Audi,101);
%loopTroughMake(BMW,102);
ODS TAGSETS.RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/103_class.rtf" STYLE=journal;
TITLE1 "Table 103: TAGSET RTF Class output with another subtitle";
TITLE3 "on a further title line";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
ODS TAGSETS.RTF CLOSE;

TITLE;FOOTNOTE;
ODS TAGSETS.RTF FILE="&out/104_class.rtf" STYLE=journal;
ODS TAGSETS.RTF PREPAGE="Table 104: this is a test";
PROC REPORT DATA=sashelp.class nowd headline spacing=2;
	COLUMN sex name age height weight;
	DEFINE sex / ORDER WIDTH=3 FLOW;
	DEFINE name / ORDER;
RUN;
ODS TAGSETS.RTF CLOSE;

OPTIONS NODATE;

%************ examples using Page X of Y in the title *********************************;
OPTIONS NODATE NONUMBER NOCENTER ORIENTATION=landscape;


OPTIONS NOBYLINE;
PROC SORT DATA=sashelp.class OUT=class; BY sex; RUN;
DATA class;
	SET class;
	pages = 2;
	IF sex = "F" 
		THEN page = 1;
		ELSE page = 2;
RUN;

PROC SORT DATA=sashelp.cars (WHERE=(make < "Chevrolet")) OUT=cars; BY make; RUN;
DATA cars;
	SET cars;
	BY make;
	RETAIN page 0;
	pages = 5;
	IF first.make 
		THEN page = page + 1;
RUN;

%MACRO outputType1(number=, postfix =);
	TITLE1 "Page #byval(page) of #byval(pages)";
	TITLE2 "Table &number: Simple Class Output with page numbers - &postfix";
	PROC REPORT DATA=class nowd headline spacing=2;
		BY page pages;
		COLUMN sex name age height weight;
		DEFINE sex / ORDER WIDTH=3 FLOW;
		DEFINE name / ORDER;
	RUN;
%MEND outputType1;

PROC PRINTTO PRINT="&out/30_class.lst" NEW; RUN;
%outputType1(number=30, postfix = listing);
PROC PRINTTO;RUN;

ODS RTF FILE="&out/31_class.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
%outputType1(number=31, postfix = rtf);
ODS RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/32_class_tagset.rtf" STYLE=journal;
%outputType1(number=32, postfix = tagset);
ODS TAGSETS.RTF CLOSE;

%MACRO outputType2(number=, postfix =);
	TITLE1 "Page #byval(page) of #byval(pages)";
	TITLE2 "Table &number: Simple CARS Output";
	TITLE3 "with page numbers - &postfix";
	PROC REPORT DATA=cars(WHERE=(make < "Chevrolet")) nowd headline spacing=2;
		COLUMN make model type msrp;
		BY page pages make;
		DEFINE make / ORDER NOPRINT;
		BREAK AFTER make / PAGE;
	RUN;
%MEND outputType2;

PROC PRINTTO PRINT="&out/33_cars.lst" NEW; RUN;
%outputType2(number=33, postfix = listing);
PROC PRINTTO;RUN;

ODS RTF FILE="&out/34_cars.rtf" BODYTITLE STARTPAGE=YES STYLE=journal;
%outputType2(number=34, postfix = rtf);
ODS RTF CLOSE;

ODS TAGSETS.RTF FILE="&out/35_cars_tagset.rtf" STYLE=journal;
%outputType2(number=35, postfix = tagset);
ODS TAGSETS.RTF CLOSE;

TITLE;FOOTNOTE;

