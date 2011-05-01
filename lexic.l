digit [0-9]
lletra [A-Za-z]
lletdig [A-Za-z0-9]
carrep [ -~]
carrepnodoc [ -!#a-~]

%%

procedure   { rl_atom(yylval, tok_begin_line, tok_begin_col); 
              return pc_procedure;}
is          { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_is;}
begin       { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_begin;}
end         { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_end;}
in          { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_in;}
out         { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_out;}
type        { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_type;}
array       { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_array;}
constant    { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_constant;}
record      { rl_atom(yylval, tok_begin_line, tok_begin_col); 
              return pc_record;}
range       { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_range;}
new			{ rl_atom(yylval, tok_begin_line, tok_begin_col);
				  return pc_new;}
of          { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_of;}
if          { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_if;}
then        { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_then;}
else        { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_else;}
for         { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_for;}
while       { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_while;}
loop        { rl_atom(yylval, tok_begin_line, tok_begin_col);
              return pc_loop;}


and  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return pc_and;}
not  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return pc_not;}
or   { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return pc_or;}
mod  { rl_atom(yylval, tok_begin_line, tok_begin_col); 
       return pc_mod;}
"+"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_mes;}
"-"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_menys;}
"*"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_producte;}
"/"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_divisio;}
"="  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_igual;}
">"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_major;}
"<"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_menor;}
">=" { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_major_igual;}
"<=" { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_menor_igual;}
"/=" { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_diferent;}
":=" { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_assignacio;}

":"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_dos_punts;}
"."  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_punt;}
".." { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_puntpunt;}
","  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_coma;}
";"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_punt_i_coma;}

"("  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_parentesi_obert;}
")"  { rl_atom(yylval, tok_begin_line, tok_begin_col);
       return s_parentesi_tancat;}

{lletra}(_?{lletdig})* { rl_id(yylval, yytext, tok_begin_line, tok_begin_col);
                         return identificador;}

{digit}+               { rl_lit_enter(yylval, yytext, tok_begin_line, 
                                      tok_begin_col);
                         return literal;}

\"{carrepnodoc}*\"     { rl_lit_string(yylval, yytext, tok_begin_line,
                                       tok_begin_col);
                         return literal;}

\'{carrep}\'           { rl_lit_caracter(yylval, yytext, tok_begin_line,
                                        tok_begin_col);
                         return literal;}

"--"[^\n]*             {null;}	--comentaris

[\t|\r|\ ]+            {null;}  	--separadors

. 	                    {return Error;}


%%

with semantica; use semantica; 
with sintactic_tokens; use  sintactic_tokens;
package a_lexic is
	
   function yylex return token;

end a_lexic;

package body a_lexic is

##

end a_lexic;
