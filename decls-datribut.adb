package body decls.datribut is

   procedure inicialitzacio is
   begin
      tbuida(tn);
   end inicialitzacio;

   procedure rl_atom(yylval : out atribut; yytext : in string;
		     lin, col : in natural) is
   begin
      yylval := (at_atom, lin, col);
   end rl_atom;

   procedure rl_id(yylval : out atribut; yytext : in string;
		   lin, col : in natural) is
      id : id_nom;
   begin
      posa_id(tn, yytext, id);
      yylval := (at_identificador, lin, col, id);
   end rl_id;

   procedure rl_lit_enter(yylval : out atribut; yytext : in string;
			  lin, col : in natural) is
   begin
      yylval := (at_lit_enter, lin, col,
		 integer(character'pos(yytext(yytext'first))) - 48, enter);
   end rl_lit_enter;

   procedure rl_lit_string(yylval : out atribut; yytext : in string;
			   lin, col : in natural) is
      id : id_string;
   begin
      posa_cad(tn, yytext(yytext'first+1..yytext'last-1), id);
      yylval := (at_lit_string, lin, col, id, cadena);
   end rl_lit_string;

   procedure rl_lit_caracter(yylval : out atribut; yytext : in string;
			     lin, col : in natural) is
   begin
      yylval := (at_lit_caracter, lin, col,
		 integer(character'pos(yytext(yytext'first+1))), caracter);
   end rl_lit_caracter;

end decls.datribut;
