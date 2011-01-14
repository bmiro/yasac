with decls.generals; use decls.generals;
with decls.dtnoms; use decls.dtnoms;
package decls.datribut is

   type tipus_atribut is (at_atom, at_identificador, at_lit_enter,
      at_lit_caracter, at_lit_string);

   type tipus_subjacent is (enter, caracter, cadena);

   type atribut(tipus : tipus_atribut := at_atom) is
      record
         lin: natural;
         col: natural;
	 case tipus is
       when at_atom => null;
	    when at_lit_enter =>
	       vale: integer; -- sera el valor enter
	       tle: tipus_subjacent := enter;
	    when at_lit_caracter =>
	       valc: integer; -- sera el codi ASCII
	       tlc: tipus_subjacent := caracter;
	    when at_lit_string =>
	       vals: integer; -- sera id_string de la taula de noms
	       tls: tipus_subjacent := cadena;
	    when at_identificador =>
	       id_n: id_nom;
            when others => null;
         end case;
      end record;

   procedure inicialitzacio;
   procedure rl_atom(yylval : out atribut; yytext : in string; lin, col : in natural);
   procedure rl_id(yylval : out atribut; yytext : in string; lin, col : in natural);
   procedure rl_lit_enter(yylval : out atribut; yytext : in string; lin, col : in natural);
   procedure rl_lit_string(yylval : out atribut; yytext : in string; lin, col : in natural);
   procedure rl_lit_caracter(yylval : out atribut; yytext : in string; lin, col : in natural);

private
   tn: Tnoms;

end decls.datribut;
