with decls.generals, decls.nodes_arbre; use decls.generals, decls.nodes_arbre;
with decls.dtnoms; use decls.dtnoms;
package decls.crea_arbre is

   procedure crea_n_dec_proc(a: out ast;
                             encap, decls, sents, identif: in ast);
   procedure crea_n_encap(a: out ast; identif, params: in ast);
   procedure crea_n_decs(a: out ast; dec, decs: in ast);
   procedure crea_n_sents(a: out ast; sent, sents: in ast);
   procedure crea_n_dec_params(a: out ast; params, param: in ast);
   procedure crea_n_dec_param(a: out ast;
                              identif, tipus, mode: in ast);
   procedure crea_n_mode(a: out ast; mode: in t_mode);
   procedure crea_n_dec_const(a: out ast; llista_id, valor, tipus: in ast);
   procedure crea_n_dec_var(a: out ast; identif, llista_id: in ast);
   procedure crea_n_dec_array(a: out ast; identif, llista_idx, tipus: in ast);
   procedure crea_n_dec_rec(a: out ast; identif, camps: in ast);
   procedure crea_n_vconst(a: out ast; lit: in ast; signe: in t_operacio);
   procedure crea_n_dec_subrang(a: out ast; identif, tipus, rang: in ast);
   procedure crea_n_llista_id(a:out ast; identif, llista_id: in ast);
   procedure crea_n_camps_rec(a: out ast; camp, camps: in ast);
   procedure crea_n_camp_rec(a: out ast; identif, tipus: in ast);
   procedure crea_n_rang(a: out ast; lim_inf, lim_sup: in ast);
   procedure crea_n_lim(a: out ast; base: in ast ;signe: in t_operacio);
   procedure crea_n_sent_buc(a: out ast; expr, sents: in ast);
   procedure crea_n_sent_flux(a: out ast; expr, sents, sents_else: in ast);
   procedure crea_n_sent_assig(a: out ast; ref, expr: in ast);
   procedure crea_n_expr(a: out ast; expr1, expr2: in ast;
                         operacio: t_operacio);
   procedure crea_n_ref(a:out ast; identif, llista_ref: in ast);
   procedure crea_n_ref_comp(a: out ast; expr, ref_comp: in ast);

   procedure rl_atom(a: out ast; lin, col: in natural);
   procedure rl_id(a: out ast; yytext: in string; lin, col: in natural);
   procedure rl_lit_enter(a: out ast; yytext: in string;
			  lin, col: in natural);
   procedure rl_lit_string(a: out ast; yytext: in string;
			   lin, col: in natural);
   procedure rl_lit_caracter(a: out ast; yytext: in string;
			     lin, col: in natural);

   procedure remunta_fill(a: out ast; fill: in ast);
   
   procedure inicia_tn;
   
   procedure crea_arbre(a: in ast);
    
private

   arrel: ast;
   tn: tnoms;

end decls.crea_arbre;
