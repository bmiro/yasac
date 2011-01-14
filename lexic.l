digit [0-9]
lletra [A-Za-z]
lletdig [A-Za-z0-9]
carrep [ -~]
carrepnodoc [ -!#a-~]

%%

procedure { rl_atom(yylval, tok_begin_line, tok_begin_col); 
            return pc_procedure;}
is 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_is;}
begin 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_begin;}
end 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_end;}
in 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_in;}
out 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_out;}
type 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_type;}
array 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_array;}
constant  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_constant;}
record 	  { rl_atom(yylval, tok_begin_line, tok_begin_col); 
            return pc_record;}
range 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_range;}
of 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_of;}
if 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_if;}
then 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_then;}
else 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_else;}
for 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_for;}
while 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_while;}
loop 	  { rl_atom(yylval, tok_begin_line, tok_begin_col);
            return pc_loop;}


and  { rl_operacio(yylval, yytext, tok_begin_line, tok_begin_col);
       return pc_and;}
not  { rl_operacio(yylval, yytext, tok_begin_line, tok_begin_col);
       return pc_not;}
or   { rl_operacio(yylval, yytext, tok_begin_line, tok_begin_col);
       return pc_or;}
mod  { rl_operacio(yylval, o_modul, tok_begin_line, tok_begin_col); 
       return pc_mod;}
"+"  { rl_operacio(yylval, o_suma, tok_begin_line, tok_begin_col);
       return s_mes;}
"-"  { rl_operacio(yylval, o_resta, tok_begin_line, tok_begin_col);
       return s_menys;}
"*"  { rl_operacio(yylval, o_mult, tok_begin_line, tok_begin_col);
       return s_producte;}
"/"  { rl_operacio(yylval, o_div, tok_begin_line, tok_begin_col);
       return s_divisio;}
"="  { rl_operacio(yylval, o_igual, tok_begin_line, tok_begin_col);
       return s_igual;}
">"  { rl_operacio(yylval, o_major, tok_begin_line, tok_begin_col);
       return s_major;}
"<"  { rl_operacio(yylval, o_menor, tok_begin_line, tok_begin_col);
       return s_menor;}
">=" { rl_operacio(yylval, o_maj_ig, tok_begin_line, tok_begin_col);
       return s_major_igual;}
"<=" { rl_operacio(yylval, o_men_ig, tok_begin_line, tok_begin_col);
       return s_menor_igual;}
"/=" { rl_operacio(yylval, o_diferent, tok_begin_line, tok_begin_col);
       return s_diferent;}
":=" { rl_operacio(yylval, yytext, tok_begin_line, tok_begin_col);
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

{lletra}(_?{lletdig})*            { rl_id(yylval, tok_begin_line, tok_begin_col);
                                    return identificador;}

{digit}+                          { rl_lit_enter(yylval, tok_begin_line, tok_begin_col);
                                    return literal;}

\"{carrepnodoc}*\"                { rl_lit_string(yylval, tok_begin_line, tok_begin_col);
                                    return literal;}

\'{carrep}\'                      { rl_lit_caracter(yylval, tok_begin_line, tok_begin_col);
                                    return literal;}

"--"[^\n]*                        {null;}	--comentaris

[\t|\r|\ ]+                       {null;}  	--separadors

. 	                          {return Error;}


%%

with decls.datribut; use decls.datribut; 
with sintactic_tokens; use  sintactic_tokens;
package a_lexic is
	
   function yylex return token;

end a_lexic;

package body a_lexic is

##

end a_lexic;
