with decls.generals, decls.nodes_arbre; use decls.generals, decls.nodes_arbre;
with decls.dtnoms; use decls.dtnoms;
package decls.crea_arbre is

   procedure inicia_tn;

-------------------------------------------------------------------------------
------------------------------Rutines Semàntiques------------------------------
-------------------------------------------------------------------------------

   procedure rs_programa(a: in ast);
   procedure rs_dec_proc(a: out ast;
                             encap, decls, sents, identif: in ast);
   procedure rs_encap(a: out ast; identif, params: in ast);
   procedure rs_encap(a: out ast; identif: in ast);
   procedure rs_parametres(a: out ast; params, param: in ast);
   procedure rs_parametres(a: out ast; param: in ast);
   procedure rs_parametre(a: out ast;
                              identif, tipus, mode: in ast);
   procedure rs_mode(a: out ast; mode: in t_mode);
   procedure rs_declaracions(a: out ast; dec, decs: in ast);
   procedure rs_declaracions(a: out ast);
   procedure rs_declaracio(a: out ast; declaracio: in ast);
   procedure rs_dec_tipus(a: out ast; declaracio: in ast);
   procedure rs_dec_const(a: out ast; llista_id, valor, tipus: in ast);
   procedure rs_vconst(a: out ast; lit: in ast; signe: in t_operacio);
   procedure rs_vconst(a: out ast; lit: in ast);
   procedure rs_dec_var(a: out ast; identif, llista_id: in ast);
   procedure rs_dec_array(a: out ast; identif, llista_idx, tipus: in ast);
   procedure rs_llista_id(a:out ast; identif, llista_id: in ast);
   procedure rs_llista_id(a:out ast; identif: in ast);
   procedure rs_dec_record(a: out ast; identif, camps: in ast);
   procedure rs_camps(a: out ast; camp, camps: in ast);
   procedure rs_camps(a: out ast; camp: in ast);
   procedure rs_camp(a: out ast; identif, tipus: in ast);
   procedure rs_dec_subrang(a: out ast; identif, tipus, rang: in ast);
   procedure rs_rang(a: out ast; lim_inf, lim_sup: in ast);
   procedure rs_lim(a: out ast; base: in ast; signe: in t_operacio);
   procedure rs_lim(a: out ast; base: in ast);
   procedure rs_sentencies(a: out ast; sent, sents: in ast);
   procedure rs_sentencies(a: out ast; sentencia: in ast);
   procedure rs_sentencia(a: out ast; sentencia: in ast);
   procedure rs_sent_bucles(a: out ast; expr, sents: in ast);
   procedure rs_sent_fluxe(a: out ast; expr, sents, sents_else: in ast);
   procedure rs_expressio(a: out ast; expr1, expr2: in ast;
                          operacio: t_operacio);
   procedure rs_expressio(a: out ast; expr: in ast);
   procedure rs_ref(a:out ast; identif, llista_ref: in ast);
   procedure rs_ref(a:out ast; identif: in ast);
   procedure rs_ref_comp(a: out ast; expr, ref_comp: in ast);
   procedure rs_sent_assignacio(a: out ast; ref, expr: in ast);
   procedure rs_sent_procedure(a:out ast; identif: in ast);

------------------------------------------------------------------------------
-------------------------------Rutines Lèxiques-------------------------------
------------------------------------------------------------------------------

   procedure rl_atom(a: out ast; lin, col: in natural);
   procedure rl_id(a: out ast; yytext: in string; lin, col: in natural);
   procedure rl_lit_enter(a: out ast; yytext: in string;
			  lin, col: in natural);
   procedure rl_lit_string(a: out ast; yytext: in string;
			   lin, col: in natural);
   procedure rl_lit_caracter(a: out ast; yytext: in string;
			     lin, col: in natural);
private

   arrel: ast;
   tn: tnoms;

end decls.crea_arbre;
