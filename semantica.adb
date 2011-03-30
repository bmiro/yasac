with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
package body semantica is

   procedure inicia_analitzador is
   begin
      tbuida(tn);
      tbuida(ts);
   end inicia_analitzador;

-------------------------------------------------------------------------------
------------------------------Rutines Semàntiques------------------------------
-------------------------------------------------------------------------------

   procedure rs_programa(a: in ast) is
   begin
      arrel := a;
   end rs_programa;


   procedure rs_dec_proc(a: out ast; encap, decls, sents, identif_inici, identif_fi: in ast) is
   begin
      a:= new node(n_dec_proc);
      a.dp_encap:= encap;
      a.dp_decls:= decls;
      a.dp_sents:= sents;
      a.dp_identif_inici:= identif_inici;
		a.dp_identif_fi:= identif_fi;
   end rs_dec_proc;

   procedure rs_encap(a: out ast; params: in ast) is
   begin
      a:= new node(n_encap);
      a.e_params:= params;
   end rs_encap;

   procedure rs_encap(a: out ast) is
   begin
    a:= null;
   end rs_encap;

   procedure rs_declaracions(a: out ast; dec, decs: in ast) is
   begin
      a:= new node(n_decs);
      a.d_decl:= dec;
      a.d_decls:= decs;
   end rs_declaracions;

   procedure rs_declaracions(a: out ast) is
   begin
      a:= null;
   end rs_declaracions;

   procedure rs_sentencies(a: out ast; sent, sents: in ast) is
   begin
      a:= new node(n_sents);
      a.s_sent:= sent;
      a.s_sents:= sents;
   end rs_sentencies;

   procedure rs_parametres(a: out ast; params, param: in ast) is
   begin
      a:= new node(n_dec_params);
      a.dpa_params:= params;
      a.dpa_param:= param;
   end rs_parametres;

   procedure rs_parametres(a: out ast; param: in ast) is
   begin
      a:= param;
   end rs_parametres;

   procedure rs_parametre(a: out ast; identif, tipus, mode: in ast) is
   begin
      a:= new node(n_dec_param);
      a.dpa_identif:= identif;
      a.dpa_tipus:= tipus;
      a.dpa_mode:= mode;
   end rs_parametre;

   procedure rs_mode(a: out ast; mode: in t_mode) is
   begin
      a:= new node(n_mode);
      a.mode:= mode;
   end rs_mode;

   procedure rs_declaracio(a: out ast; declaracio: in ast) is
   begin
      a:= declaracio;
   end rs_declaracio;

   procedure rs_dec_tipus(a: out ast; declaracio: in ast) is
   begin
      a:= declaracio;
   end rs_dec_tipus;

   procedure rs_dec_const(a: out ast; identif, valor, tipus: in ast) is
   begin
      a:= new node(n_dec_const);
      a.dc_identif:= identif;
      a.dc_id_tipus:= tipus;
      a.dc_vconst:= valor;
   end rs_dec_const;

   procedure rs_vconst(a: out ast; lit: in ast; signe: in t_operacio) is
   begin
      a:= new node(n_vconst);
      a.v_signe:= signe;
      a.v_literal:= lit;
   end rs_vconst;

   procedure rs_vconst(a: out ast; lit: in ast) is
   begin
      a:= lit;
   end rs_vconst;

   procedure rs_dec_var(a: out ast; identif_var, identif_tipus: in ast) is
   begin
      a:= new node(n_dec_var);
		a.dv_id_var:= identif_var;
      a.dv_id_tipus:= identif_tipus;
   end rs_dec_var;

   procedure rs_dec_array(a: out ast; identif, llista_idx, tipus: in ast) is
   begin
		a:= new node(n_dec_array);
      a.da_identif:= identif;
      a.da_llista_idx:= llista_idx;
      a.da_id_tipus:= tipus;
   end rs_dec_array;

   procedure rs_llista_id(a: out ast; identif, llista_id: in ast) is
   begin
      a:= new node(n_llista_id);
      a.li_identif:= identif;
      a.li_llista_id:= llista_id;
   end rs_llista_id;

   procedure rs_llista_id(a: out ast; identif: in ast) is
   begin
      a:= identif;
   end rs_llista_id;

   procedure rs_dec_record(a: out ast; identif, camps: in ast) is
   begin
      a:= new node(n_dec_rec);
      a.dr_identif:= identif;
      a.dr_camps:= camps;
   end rs_dec_record;

   procedure rs_camps(a: out ast; camp, camps: in ast) is
   begin
      a:= new node(n_camps_rec);
      a.csr_camp:= camp;
      a.csr_llista_camps:= camps;
   end rs_camps;

   procedure rs_camps(a: out ast; camp: in ast) is
   begin
      a:= camp;
   end rs_camps;

   procedure rs_camp(a: out ast; identif, tipus: in ast) is
   begin
      a:= new node(n_camp_rec);
      a.cr_identif:= identif;
      a.cr_id_tipus:= tipus;
   end rs_camp;

   procedure rs_dec_subrang(a: out ast; identif, tipus, rang: in ast) is
   begin
      a:= new node(n_dec_subrang);
      a.ds_identif:= identif;
      a.ds_id_tipus:= tipus;
      a.ds_rang:= rang;
   end rs_dec_subrang;

   procedure rs_rang(a: out ast; lim_inf, lim_sup: in ast) is
   begin
      a:= new node(n_rang);
      a.r_lim_inf:= lim_inf;
      a.r_lim_sup:= lim_sup;
   end rs_rang;

   procedure rs_lim(a: out ast; base: in ast; signe: in t_operacio) is
   begin
      a:= new node(n_lim);
      a.lim:= base;
      a.signe:= signe;
   end rs_lim;

   procedure rs_lim(a: out ast; base: in ast) is
   begin
      a:= base;
   end rs_lim;

   procedure rs_sentencies(a: out ast; sentencia: in ast) is
   begin
      a:= sentencia;
   end rs_sentencies;

   procedure rs_sentencia(a: out ast; sentencia: in ast) is
   begin
      a:= sentencia;
   end rs_sentencia;

   procedure rs_sent_bucles(a: out ast; expr, sents: in ast) is
   begin
      a:= new node(n_sent_buc);
      a.sb_condicio:= expr;
      a.sb_sents:= sents;
   end rs_sent_bucles;

   procedure rs_sent_fluxe(a: out ast; expr, sents, sents_else: in ast) is
   begin
      a:= new node(n_sent_flux);
      a.sf_condicio:= expr;
      a.sf_sents:= sents;
      a.sf_sents_else:= sents_else;
   end rs_sent_fluxe;

   procedure rs_expressio(a: out ast; expr1, expr2: in ast;
                          operacio: t_operacio) is
   begin
      a:= new node(n_expr);
      a.e_camp1:= expr1;
      a.e_operacio:= operacio;
      a.e_camp2:= expr2;
   end rs_expressio;

   procedure rs_expressio(a: out ast; expr: in ast) is
   begin
      a:= expr;
   end rs_expressio;

   procedure rs_ref(a: out ast; identif, llista_ref: in ast) is
   begin
      a:= new node(n_ref);
      a.r_identif:= identif;
      a.r_llista_ref:= llista_ref;
   end rs_ref;

   procedure rs_ref(a: out ast; identif: in ast) is
   begin
      a:= identif;
   end rs_ref;

   procedure rs_ref_comp(a: out ast; expr, ref_comp: in ast) is
   begin
      a:= new node(n_ref_comp);
      a.rc_expr:= expr;
      a.rc_llista_ref:= ref_comp;
   end rs_ref_comp;

   procedure rs_sent_assignacio(a: out ast; ref, expr: in ast) is
   begin
      a:= new node(n_sent_assig);
      a.sa_ref:= ref;
      a.sa_expr:= expr;
   end rs_sent_assignacio;

	--TODO Revisar
   procedure rs_sent_procedure(a: out ast; identif: in ast) is
   begin
      a:= identif;
   end rs_sent_procedure;

------------------------------------------------------------------------------
-------------------------------Rutines Lèxiques-------------------------------
------------------------------------------------------------------------------

   procedure rl_atom(a : out ast; lin, col : in natural) is
   begin
      a := new node'(n_atom, lin, col);
   end rl_atom;

   procedure rl_id(a : out ast; yytext : in string;
		   lin, col : in natural) is
      id : id_nom;
   begin
      posa_id(tn, yytext, id);
		a := new node'(n_identif, lin, col, id);
   end rl_id;

   procedure rl_lit_enter(a : out ast; yytext : in string;
			  lin, col : in natural) is
   begin
      a := new node'(n_lit_enter, lin, col,
		 valor(character'pos(yytext(yytext'first))) - 48);
   end rl_lit_enter;

   procedure rl_lit_string(a : out ast; yytext : in string;
			   lin, col : in natural) is
      id : id_string;
   begin
      posa_cad(tn, yytext(yytext'first+1..yytext'last-1), id);
      a := new node'(n_lit_string, lin, col, id);
   end rl_lit_string;

   procedure rl_lit_caracter(a : out ast; yytext : in string;
			     lin, col : in natural) is
   begin
      a := new node'(n_lit_caracter, lin, col,
		 valor(character'pos(yytext(yytext'first+1))));
   end rl_lit_caracter;
   
end semantica;

