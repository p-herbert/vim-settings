" Vim syntax file
" Language:   SAS
" Maintainer:   James Kidd <james.kidd@covance.com>
" Last Change: 6/8/2015 4:45:19 PM
"      Added highlighting for additional keywords and such;
"      Attempted to match SAS default syntax colors;
"      Changed syncing so it doesn't lose colors on large blocks;
"      Much thanks to Bob Heckel for knowledgeable tweaking.
"      Major revisions by Alan Masinter designed for Solarized colorscheme
"  For version 5.x: Clear all syntax items
"  For version 6.x: Quit when a syntax file was already loaded
if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

syn case ignore 

"big region for all sas datasteps. maybe should stop at any proc, quit, run,
"etc?
syn region sasDataStep   matchgroup=sasStep start="^\s*data\>"  end="\<run\s*;"he=e-1 transparent keepend contains=TOP

"Dont format macro variables within single-quoted strings
"But do with double-quoted strings (Alan Masinter)
syn region sasString1   start=+'+  skip=+\\"+  end=+'+ containedin=sasFmtStatement extend
syn region sasString2   start=+"+  skip=+\\"+  end=+"+ contains=sasMacroVar,sasMacroFunction,sasMacro extend

"this escaped quotation mark will take precedence over matching sasString1/2
"regions
syn keyword sasQuoteEscaped %" containedin=pctStr
syn keyword sasQuoteEscaped %' containedin=pctStr

" Want region from 'cards;' to ';' to be captured (Bob Heckel)
syn region sasCards     start="^\s*CARDS.*" end="^\s*;\s*$"
syn region sasCards   start="^\s*DATALINES.*" end="^\s*;\s*$"


syn region sasComment   start="/\*" end="\*/" contains=sasTodo
" Ignore misleading //JCL SYNTAX... (Bob Heckel)
syn region sasComment   start="[^/][^/]/\*"ms=s+2  end="\*/" contains=sasTodo

"Macro comments can be in the middle of another statement
"highlight strings because qutoes within this kind of comment can mess up a program
syn region sasComment start="%\*" end=";" contains=sasTodo,sasString1,sasString2

"Match a region begining with an asterisk following a semicolon 
"Ends with next semicolon
"ALSO, macro code does resolve in this kind of comment so contain this
"appropraitely
syn region sasComment start="^\s*\*" start=";\(\s\|\n\|\r\)*\*"lc=1 end=";"me=e+1 contains=sasTodo


"Have to not match sql too for proc statements. Will match any proc, including
"invalid ones but whatever I dont want to specify every possible proc



syn region sasProc   matchgroup=sasStep start="\<PROC\>\s\+\(SQL\)\@!\w\+"  end="\<run\s*;"he=e-1 transparent keepend contains=TOP,sasDataStep,sasSQL,sqlStatement,sasDataOpts
syn region sasProcOpts start="\(\<PROC\>\s\+\(SQL\)\@!\w\+\)\@<=" end=";"he=e-1 transparent containedin=sasProc

"todo this dosent work exactly if you have contained macro fields
syn region sasDataOpts   start="\(\<\(data\|set\|merge\)\>\w*\)\@<="  end=";"he=e-1 transparent containedin=sasDataStep contains=TOP
syn region tablesRegion matchgroup=Function start="\<tables\>\([\s\w]\+\)\@<=" end=";"he=e-1 transparent containedin=sasProc contained contains=tablesOpt

syn keyword tablesOpt agree all bdt binomial binomialc chisq cl cmh cmh1 cmh2 fischer gailsimon jt measures contained
syn keyword tablesOpt missing plcorr relrisk riskdiff riskdiffc  trend cellchi2 cumcol deviation expected   contained
syn keyword tablesOpt missprint sparse totpct crosslist list nocol nocum nofreq nopercent noprint norow     contained
syn keyword tablesOpt nosparse nowarn printkwt scorout containedin=tablesRegion contained
hi link tablesOpt Function




"todo eventually should contain elements specific to each proc region...
syn match sasProcOpt "\<data\s*="he=e-1      containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<contents\s*="he=e-1  containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<blankline\s*="he=e-1 containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<rows\s*="he=e-1      containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<heading\s*="he=e-1   containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<split\s*="he=e-1     containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<width\s*="he=e-1     containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<ci\s*="he=e-1        containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<obs\s*="he=e-1       containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<base\s*="he=e-1      containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<out\s*="he=e-1       containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<prefix\s*="he=e-1    containedin=sasProcOpts,sasProc contained
syn match sasProcOpt "\<order\s*="he=e-1     containedin=sasProcOpts,sasProc contained

syn keyword sasProcOpt paired append nodup nodupkey containedin=sasProcOpts contained
syn keyword sasProcOpt noobs round style sumlabel   containedin=sasProcOpts contained
syn keyword sasProcOpt cochran                      containedin=sasProcOpts contained 

syn keyword sasProcOpt class                        containedin=sasProc contained
syn match sasProcOpt "\<out\s*="he=e-1     containedin=sasProc contained

syn keyword SasProcOpt tables expected cellchi2 norow nocol nopercent chisq n nmiss pchi lrchi weight containedin=sasProc contained

"proc transpose region with extra keywords
syn region sasTranspose   matchgroup=sasStep start="\<PROC\s\+transpose\W"  end="run\s*;"he=e-1 transparent  contains=transStatement,sasProcOpt,sasComment
syn keyword transStatement  id idlabel var by               containedin=sasTranspose contained


"todo make this more efficient with keywords instead?
syn match sasDataOpt "\<ALTER\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<BUFNO\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<BUFSIZE\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<CNTLLEV\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<COMPRESS\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<DLDMGACTION\s*="he=e-1 containedin=sasDataOpts contained
syn match sasDataOpt "\<DROP\s*="he=e-1        containedin=sasDataOpts contained
syn match sasDataOpt "\<ENCRYPT\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<FILECLOSE\s*="he=e-1   containedin=sasDataOpts contained
syn match sasDataOpt "\<FIRSTOBS\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<GENMAX\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<GENNUM\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<IDXNAME\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<IDXWHERE\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<IN\s*="he=e-1          containedin=sasDataOpts contained
syn match sasDataOpt "\<INDEX\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<KEEP\s*="he=e-1        containedin=sasDataOpts contained
syn match sasDataOpt "\<LABEL\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<OBS\s*="he=e-1         containedin=sasDataOpts contained
syn match sasDataOpt "\<OBSBUF\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<OUTREP\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<POINTOBS\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<PW\s*="he=e-1          containedin=sasDataOpts contained
syn match sasDataOpt "\<PWREQ\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<READ\s*="he=e-1        containedin=sasDataOpts contained
syn match sasDataOpt "\<RENAME\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<REPEMPTY\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<REPLACE\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<REUSE\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<SORTEDBY\s*="he=e-1    containedin=sasDataOpts contained
syn match sasDataOpt "\<SPILL\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<TOBSNO\s*="he=e-1      containedin=sasDataOpts contained
syn match sasDataOpt "\<TYPE\s*="he=e-1        containedin=sasDataOpts contained
syn match sasDataOpt "\<WHERE\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<WHEREUP\s*="he=e-1     containedin=sasDataOpts contained
syn match sasDataOpt "\<WRITE\s*="he=e-1       containedin=sasDataOpts contained
syn match sasDataOpt "\<END\s*="he=e-1         containedin=sasDataOpts contained

hi link sasProcOpt Function
hi link sasDataOpt Function

syn match sasHashName "\(declare\s\+\(hash\|hiter\)\s\+\)\@<=\w\+"
syn match sasHashDeclare "\(declare\s\+\(hash\|hiter\)\s\+\)"
hi link sasHashDeclare Function
hi link sasHashName Constant

syn region hashFxn matchgroup=Function start="\(\a\w*\.\)\@<=\(replace\|find\|output\|add\|has_next\|next\|first\|last\)(\@=" end=")\@=" transparent contains=TOP

syn match sasStatement "dataset\s*:"he=e-1   containedin=hashDeclaration contained
syn match sasStatement "multidata\s*:"he=e-1 containedin=hashDeclaration contained 
syn match sasStatement "ordered\s*:"he=e-1   containedin=hashDeclaration contained
syn match sasStatement "hashexp\s*:"he=e-1   containedin=hashDeclaration contained 

syn match sasStatement "key\s*:"he=e-1       containedin=hashFxn         contained
syn match sasStatement "data\s*:"he=e-1      containedin=hashFxn         contained
syn match sasStatement "dataset\s*:"he=e-1   containedin=hashFxn         contained


"syn keyword sasStep RUN QUIT DATA
syn keyword sasConditional      IF THEN ELSE WHILE UNTIL WHEN OTHERWISE

"removed format, length, lengthn, attrib, informat from this list of keywords
"because these are now covered in sasFmtStatement
"removed MISSING (function only?) 2014/11/06
syn keyword sasStatement   AND OR NOT IN ID TO DESCENDING
syn keyword sasStatement   DO END ABORT ARRAY BY CALL CARDS CARDS4 CATNAME
syn keyword sasStatement   CONTINUE DATALINES DATALINES4 DELETE DISPLAY
syn keyword sasStatement   DM DROP ENDSAS ERROR FILE FILENAME FOOTNOTE
syn keyword sasStatement   GOTO INFILE KEEP
syn keyword sasStatement   LABEL LEAVE LIBNAME LINK LIST LOSTCARD
syn keyword sasStatement   MERGE MODIFY OUTPUT PAGE
syn keyword sasStatement   REDIRECT REMOVE RENAME REPLACE RETAIN
syn keyword sasStatement   RETURN SELECT SET SKIP STARTSAS STOP TITLE
syn keyword sasStatement   UPDATE WAITSAS WHERE WINDOW X SYSTASK
syn keyword sasStatement   OVER


" SAS/GRAPH statements (Zhenhuan Hu)
syn keyword sasStatement GOPTIONS LEGEND PATTERN PLOT

" SAS/CHART statements (Zhenhuan Hu)
syn keyword sasStatement BLOCK HBAR PIE STAR VBAR

" SAS/UNIVARIATE syntax (Zhenhuan Hu)
syn keyword sasStatement CDFPLOT HISTOGRAM INSET PPPLOT PROBPLOT QQPLOT
"
" Match declarations have to appear one per line (Paulo Tanimoto)
syn match sasStatement "FOOTNOTE\d"
syn match sasStatement "TITLE\d"
syn match sasStatement "AXIS\d\{1,2}"
syn match sasStatement "SYMBOL\d\{1,3}"


"library names
"also does hash functions - name.replace() etc
"also does first.whatever and hashName.whatever... guess that's OK
"ignores ones that begin with a backslash (since these are probably filenames)
"
"has to be 1-8 chars?
"syn match libName "\<\\\@<!\a\w\{0,7}\(\.\(&\|\a\w*\)\)\@="
"let it be as long as possible
syn match libName "\<\\\@<!\a\w*\(\.\(&\|\a\w*\)\)\@="
hi link libName Constant


" ODS keywords (Zhenhuan Hu)
syn keyword sasODSKwd ODS CLOSE CHTML CSVALL contained
syn keyword sasODSKwd DOCBOOK DOCUMENT ESCAPECHAR EXCLUDE contained
syn keyword sasODSKwd GRAPHICS HTML HTMLCSS HTML3 IMODE LISTING contained
syn keyword sasODSKwd MAKEUP OUTPUT PACKAGESm PATH PCL PDF PHTML contained
syn keyword sasODSKwd PRINTER PROCLABEL PROCTITLE PS RESULTWS RTF contained
syn keyword sasODSKwd SELECT SHOW TAGSET TEXT TRACE USEGOPT VERIFY WML contained
syn region sasODS start="\(^\|;\)\s*ODS " end=";" contains=sasODSKwd, sasString1, sasString2, sasNumber, sasComment, sasMacroFunction, sasMacroVar,libname

                                                                    
" Keywords that are used in Proc SQL
syn region sasSQL   matchgroup=sasStep start="PROC\s\+SQL\W"  end="run\s*;"he=e-1 end="quit\s*;"he=e-1 keepend contains=sasString1,sasString2,sasNumber,sasComment,sasMacroFunction,sasMacroVar,libname,sasFunction

syn match sqlStatement  "\<UNION\(\s\+ALL\)\?\>" containedin=sasSQL contained

syn keyword sqlStatement  ADD AND ALTER AS CASCADE CHECK CREATE         containedin=sasSQL contained
syn keyword sqlStatement  DELETE DESCRIBE DISTINCT DROP FOREIGN         containedin=sasSQL contained
syn keyword sqlStatement  FROM GROUP HAVING INDEX INSERT INTO IN        containedin=sasSQL contained
syn keyword sqlStatement  JOIN KEY LEFT LIKE MESSAGE MODIFY MSGTYPE NOT containedin=sasSQL contained
syn keyword sqlStatement  NULL ON OR ORDER PRIMARY REFERENCES           containedin=sasSQL contained 
syn keyword sqlStatement  RESET RESTRICT RIGHT SELECT SET TABLE TABLES  containedin=sasSQL contained
syn keyword sqlStatement  UNIQUE UPDATE VALIDATE VIEW WHERE             containedin=sasSQL contained
syn keyword sqlStatement  CALCULATED INTO: SEPARATED COUNT LEFT         containedin=sasSQL contained
syn keyword sqlStatement  DESC EXCEPT FULL BY OUTER IS INTERSECT        containedin=sasSQL contained

syn keyword sqlConditional  CASE WHEN END ELSE THEN                     containedin=sasSQL contained 

syn match sqlStatement  "\<label\s*="he=e-1                             containedin=sasSQL contained
syn match sqlStatement  "\<length\s*="he=e-1                            containedin=sasSQL contained

" this one regex should cover all macro vars??
" idea is: a contained macro unit is [&text.] = (&\w*\.=)
" whole macro variable is & followed by any amount of text and macro units and
" then terminated by a single . (inclusive) or non-word character
" must be followed by at least one word character or macro unit (without
" required .)
" two starting && is treated as 1
"
syn match sasMacroVar "&\{1,2}\(\w\|\(&\w*\.\=\w*\)\)\w*\(&\w*\.\w*\)*\.\=" containedin=ALLBUT,sasComment

" I think there are still some weird edge cases where this doesnt work exactly
" right but hopefully those are rare enough use cases

"maybe experiment around with having more contained arguments
"syn region sasMacroFunction matchgroup=Type start="%\w\+\>(" end=")"  transparent contains=innerParen,sasMacroVar,sasComment,sasMacroFunction,sasNumber,libname,sasSysfunc             containedin=ALLBUT,sasComment
"syn region sasSysfunc       matchgroup=Type start="%sysfunc(" end=")" transparent contains=innerParen,sasMacroVar,sasComment,sasMacroFunction,sasNumber,libname,sasFunction,sasPutFxn,sasSysfunc containedin=ALLBUT,sasComment
"syn region sasMacroCall matchgroup=Type start="%\w\+\(\w\|(\)\@!" end="$" end=";" transparent keepend containedin=ALLBUT,sasComment

"removed above 3 because of buginesss

"nextgroup stuff makes this fast
"from the documentation:
   "If there is a match, this group
   "will be used, even when it is not mentioned in the "contains" field of the
   "current group.
syn match sasMacro "%\w\+" containedin=ALLBUT,sasComment 
"syn match sasMacro "%\w\+" containedin=ALLBUT,sasComment nextgroup=sasMacroParen

"got rid of containing sasstring because of %str() lines with embedded escaped
"quotes
"syn region sasMacroParen start="(" end=")" contained contains=sasComment,sasString1,sasString2
"syn region sasMacroParen start="(" end=")" contained contains=sasComment,sasFunction,innerParen
hi link sasMacro Type

syn region sasMacroPut start="%put" end=";" contains=sasComment,sasString1,sasString2
hi link sasMacroPut Normal

syn region pctStr start=+\c\(%str\)\@<=(+rs=e+1,ms=e+1 end=+)+he=e-1 contains=innerParen
syn region innerParen start="(" end=")" transparent containedin=pctStr contained

"syn region pctNRStr start=+\c\(%nrstr\)\@<=(+ skip=+%)+ end=+)+he=e-1


"todo maybe limit groups that can start in innerparen in some creative way
"the goal would be such that when an innerParen begins within
"a sasMacroFunction it should contain only the groups contained in
"sasMacroFunction
"the weird thing is that when an innerParen begins normally elsewhere, it
"should contain ALL


" List of SAS function names
syn keyword sasFunctionName ABS ADDR AIRY ARCOS ARSIN ATAN ATTRC ATTRN              containedin=sasFunction contained
syn keyword sasFunctionName ANYALNUM ANYALPHA ANYDIGIT ANYPUNCT ANYSPACE            containedin=sasFunction contained
syn keyword sasFunctionName BAND BETAINV BLSHIFT BNOT BOR BRSHIFT BXOR              containedin=sasFunction contained
syn keyword sasFunctionName BYTE COMPARE COMPGED COMPLEV CAT CATS CATT CATX         containedin=sasFunction contained
syn keyword sasFunctionName CDF CEIL CEXIST CINV CLOSE CNONCT COLLATE               containedin=sasFunction contained
syn keyword sasFunctionName COMPBL COMPOUND COMPRESS COS COSH COUNT COUNTC CUROBS   containedin=sasFunction contained
syn keyword sasFunctionName CSS CV DACCDB DACCDBSL DACCSL DACCSYD DACCTAB           containedin=sasFunction contained
syn keyword sasFunctionName DAIRY DATE DATEJUL DATEPART DATETIME DAY                containedin=sasFunction contained
syn keyword sasFunctionName DCLOSE DEPDB DEPDBSL DEPDBSL DEPSL DEPSL                containedin=sasFunction contained
syn keyword sasFunctionName DEPSYD DEPSYD DEPTAB DEPTAB DEQUOTE DHMS                containedin=sasFunction contained
syn keyword sasFunctionName DIF DIGAMMA DIM DINFO DNUM DOPEN DOPTNAME               containedin=sasFunction contained
syn keyword sasFunctionName DOPTNUM DREAD DROPNOTE DSNAME ERF ERFC EXIST            containedin=sasFunction contained
syn keyword sasFunctionName EXP FAPPEND FCLOSE FCOL FDELETE FETCH FETCHOBS          containedin=sasFunction contained
syn keyword sasFunctionName FEXIST FGET FILEEXIST FILENAME FILEREF FIND FINDC FINFO containedin=sasFunction contained
syn keyword sasFunctionName FINV FIPNAME FIPNAMEL FIPSTATE FLOOR FNONCT             containedin=sasFunction contained
syn keyword sasFunctionName FNOTE FOPEN FOPTNAME FOPTNUM FPOINT FPOS                containedin=sasFunction contained
syn keyword sasFunctionName FPUT FREAD FREWIND FRLEN FSEP FUZZ FWRITE               containedin=sasFunction contained
syn keyword sasFunctionName GAMINV GAMMA GETOPTION GETVARC GETVARN HBOUND           containedin=sasFunction contained
syn keyword sasFunctionName HMS HOSTHELP HOUR IBESSEL ID IDLABEL INDEX INDEXC       containedin=sasFunction contained
syn keyword sasFunctionName INTRR IRR JBESSEL JULDATE KURTOSIS LAG LBOUND           containedin=sasFunction contained
syn keyword sasFunctionName LEFT LENGTH LENGTHC LENGTHM LENGTHN                     containedin=sasFunction contained
syn keyword sasFunctionName LGAMMA LIBNAME LIBREF LOG LOG10                         containedin=sasFunction contained
syn keyword sasFunctionName LOG2 LOGPDF LOGPMF LOGSDF LOWCASE MAX MDY               containedin=sasFunction contained
syn keyword sasFunctionName MEAN MIN MINUTE MISSING MOD MONTH MOPEN MORT N          containedin=sasFunction contained
syn keyword sasFunctionName NETPV NMISS NORMAL NOTALNUM NOTAPLHA NOTDIGIT           containedin=sasFunction contained
syn keyword sasFunctionName NOTUPPER NOTE NPV OPEN ORDINAL                          containedin=sasFunction contained
syn keyword sasFunctionName PATHNAME PDF PEEK PEEKC PMF POINT POISSON POKE          containedin=sasFunction contained
syn keyword sasFunctionName PROBBETA PROBBNML PROBCHI PROBF PROBGAM                 containedin=sasFunction contained
syn keyword sasFunctionName PROBHYPR PROBIT PROBNEGB PROBNORM PROBT PROPCASE        containedin=sasFunction contained
syn keyword sasFunctionName PRXCHANGE PRXMATCH PRXNEXT PRXPAREN PRXPARSE PRXPOSN    containedin=sasFunction contained
syn keyword sasFunctionName RANGAM RANGE RANK RANNOR RANPOI RANTBL RANTRI           containedin=sasFunction contained
syn keyword sasFunctionName RANUNI REPEAT RESOLVE REVERSE REWIND RIGHT              containedin=sasFunction contained
syn keyword sasFunctionName ROUND SAVING SCAN SCANQ SDF SECOND SIGN SIN SINH        containedin=sasFunction contained
syn keyword sasFunctionName SKEWNESS SOUNDEX SPEDIS SQRT STD STDERR STFIPS          containedin=sasFunction contained
syn keyword sasFunctionName STNAME STNAMEL STRIP SUBSTR SUM SYMGET SYSGET SYSMSG    containedin=sasFunction contained
syn keyword sasFunctionName SYSPROD SYSRC SYSTEM TAN TANH TIME TIMEPART             containedin=sasFunction contained
syn keyword sasFunctionName TINV TNONCT TODAY TRANSLATE TRANWRD TRIGAMMA            containedin=sasFunction contained
syn keyword sasFunctionName TRIM TRIMN TRUNC UNIFORM UPCASE USS VAR                 containedin=sasFunction contained
syn keyword sasFunctionName VARFMT VARINFMT VARLABEL VARLEN VARNAME                 containedin=sasFunction contained
syn keyword sasFunctionName VARNUM VARRAY VARRAYX VARTYPE VERIFY VFORMAT            containedin=sasFunction contained
syn keyword sasFunctionName VFORMATD VFORMATDX VFORMATN VFORMATNX VFORMATW          containedin=sasFunction contained
syn keyword sasFunctionName VFORMATWX VFORMATX VINARRAY VINARRAYX VINFORMAT         containedin=sasFunction contained
syn keyword sasFunctionName VINFORMATD VINFORMATDX VINFORMATN VINFORMATNX           containedin=sasFunction contained
syn keyword sasFunctionName VINFORMATW VINFORMATWX VINFORMATX VLABEL                containedin=sasFunction contained
syn keyword sasFunctionName VLABELX VLENGTH VLENGTHX VNAME VNAMEX VTYPE             containedin=sasFunction contained
syn keyword sasFunctionName VTYPEX WEEKDAY YEAR YYQ ZIPFIPS ZIPNAME ZIPNAMEL        containedin=sasFunction contained
syn keyword sasFunctionName ZIPSTATE SYMPUT SYMPUTX                                 containedin=sasFunction contained
syn keyword sasFunctionName PRXSUBSTR QTR QUOTE RANBIN RANCAU RANEXP                containedin=sasFunction contained
syn keyword sasFunctionName INDEXW INT INTCK INTNX                                  containedin=sasFunction contained
syn keyword sasFunctionName PUT PUTC PUTN                                           containedin=sasFunction contained
syn keyword sasFunctionName INPUT INPUTC INPUTN                                     containedin=sasFunction contained
syn keyword sasFunctionName COALESCE COALESCEC                                      containedin=sasFunction contained

" Function names must be followed by a left parenthesis (Zhenhuan Hu)
syn match sasFunction "\(%\|\w\)\@<!\w\+(\@=" transparent contains=sasFormat,sasHashName,hashFxn
"syn region sasFunction matchgroup=Function start="\w\+\>(" end=")" transparent contains=innerParen,sasMacroVar,sasComment,sasMacroFunction,libname containedin=ALLBUT,sasComment

" End of SAS functions

" SAS format statements
" actually these dont work with macro code because the macro ; ends the region
"syn region sasFmtStatement  matchgroup=sasStatement start="\<\(in\)\=put "                end=";"he=e-1 transparent keepend extend contains=sasFormatValue
"syn region sasFmtStatement  matchgroup=sasStatement start="\<length\>"                    end=";"he=e-1 transparent keepend extend contains=sasFormatValue
"syn region sasFmtStatement  matchgroup=sasStatement start="\<format\>"                   end=";"he=e-1 transparent keepend extend contains=sasFormatValue
"syn region sasFmtStatement  matchgroup=sasStatement start="\<informat\>"                 end=";"he=e-1 transparent keepend extend contains=sasFormatValue
"syn region sasFmtStatement  matchgroup=sasStatement start="\<attrib\>"                   end=";"he=e-1 transparent keepend extend contains=sasFormatValue,attribKeyword
syn keyword formatKeyword input put length format informat attrib label transcode
hi link formatKeyword Function

"todo - go and define all the other valid formats..
syn match sasFormatValue "\<:\=\$\a\w*\.\=\>"
syn match sasFormatValue "\<:\=\$\d\+\.\=\>"
syn match sasFormatValue "\<\d\+\.\=\>"
syn match sasFormatValue "\<\w\+\.\>"
syn match sasFormatValue "PERCENTN\=\d\+\.\d\+"

hi link sasFormatValue Constant

syn match sasNumber   "-\=\<\d*\.\=\d\+\>"
syn match sasNumber   "-\=\<\d\+\.\=\d*\>"


" Handy settings for using vim with log files
"syn keyword sasLogMsg   NOTE:
"syn keyword sasWarnMsg   WARNING: WARNING
"syn keyword sasErrMsg   ERROR: ERROR

" Always contained in a comment (Bob Heckel)
syn keyword sasTodo   TODO TBD FIXME XXX contained

" These don't fit anywhere else (Bob Heckel).
" Changed to keyword (AM)
syn keyword sasInternalVariable   _ALL_ _AUTOMATIC_ _CHARACTER_ _INFILE_ _N_
syn keyword sasInternalVariable   _NAME_ _NULL_ _NUMERIC_ _USER_ _WEBOUT_ 

"Added these which get reated or are other automatic variables 12/31/2013
syn keyword sasInternalVariable   _FREQ_ _TYPE_ _LAST_ _DATA_ _ERROR_

"  Define the default highlighting.
"  For version 5.7 and earlier: only when not done already
"  For version 5.8 and later: only when an item doesn't have highlighting yet

if version >= 508 || !exists("did_sas_syntax_inits")
   if version < 508
      let did_sas_syntax_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif
        
        "Notes on colors for solarized and their aliases:
        " Normal - no color
        " Comment - grey italics
        "
        " yellow             Type
        " orange             Preproc
        " red                Special
        " magenta            TODO
        " violet             Underlined
        " blue               Fucntion, Identifier
        " cyan               Constant
        " green              Statement
        "
        " Other colors used - look in solarized.vim
        " grey - normal
        " grey italics - comment
        " ignore - hidden
        " error - red
        " 
       HiLink sasStep        Statement
       HiLink sasProcKwd     Statement
       HiLink sasODSKwd      Statement
       HiLink sasConditional Statement
       HiLink sqlConditional Statement

       HiLink sasFunctionName Function
       HiLink sasStatement    Function
       HiLink sqlStatement    Function
       HiLink transStatement  Function
       HiLink sasProcOption   Function

       HiLink sasMacroFunction Type
       HiLink sasMacroVar      PreProc

       HiLink sasLogMsg           Special
       HiLink sasInternalVariable Special

       HiLink sasComment     Comment

       HiLink sasNumber      Constant

       HiLink sasString1     Underlined
       HiLink sasString2     UnderLined

       HiLink sasErrMsg      ErrorMsg
       HiLink sasWarnMsg     WarningMsg
       HiLink sasCards       MoreMsg
       HiLink sasTodo        Todo

   delcommand HiLink

endif

" Syncronize from beginning to keep large blocks from losing
" syntax coloring while moving through code.
syn sync fromstart

let b:current_syntax = "sas"

" vim: ts=8
