%{
#include "tiny.tab.h"
#include <string.h>
#include <stdlib.h>

%}

%option yylineno
%%

[ \t]+		/* ignore tabs */;
\n			{ }; 
\r\n			{ };
\r			{ };
"#".*		/* comment */;

"*"			return '*';
"/"			return '/';
"+"			return '+';
"-"			return '-';
"("			return '(';
")"			return ')';
";"			return ';';
"="			return '=';
":"			return ':';

"var"		return T_var;

"string"	return T_string;
"float"		return T_float;
"int"		return T_int;

"while"		return T_while;
"do"		return T_do;
"done"		return T_done;

"print"		return T_print;
"read"		return T_read;

"if"		return T_if;
"then"		return T_then;
"else"		return T_else;
"endif"		return T_endif;

\"[a-zA-Z0-9?!, .]*\" {
	yylval.stringconst = (char *) malloc (strlen (yytext) + 1);
	sprintf (yylval.stringconst, "%s", yytext); 
	return T_string_lit; 
}

((0|[1-9][0-9]*)\.[0-9]*|(\.[0-9]+)) {
	yylval.floatconst = atof (yytext);
	return T_float_lit;
}

\"*\" return yytext[0];

[a-zA-Z_][a-zA-Z0-9_]* {
	yylval.stringconst = (char *) malloc (strlen (yytext) + 1);
	sprintf (yylval.stringconst, "%s", yytext); 
	return T_id; 
}

0|([1-9][0-9]*) {
	yylval.intconst = atoi (yytext);
	return T_int_lit;
}

. return yytext[0];
%%

