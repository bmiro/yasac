with delcs.
package decls.arbre is
   type node;
   type node is access node;
   type tnode is (n_dec_proc, n_encap, n_decs, n_sents, n_ident, n_dec_params,
		  n_dec_param, n_mode, n_dec_const, n_dec_var,
		  n_dec_array, n_dec_rec, dec_subrang, n_llista_id,
		  n_val_const, n_lit, n_camps_rec, n_camp_rec, n_rang, n_lim,
		  n_sent, n_sent_buc, n_sent_flux, n_sent_proc, n_sent_assig,
		  n_expr, n_ref, n_ref_comp, n_id, n_lit
		  ); --TODO quadrar linies
   type node (tnd: tnode) is
      record
	 case tnd is
	 when n_dec_proc =>
	    dp_encap: pnode;
	    dp_decls: pnode;
	    dp_sents: pnode;
	    dp_identif: pnode;
	 when n_encap =>
	    e_identif: id_nom;
	    e_params: pnode;
	 when n_decs =>
	    d_decl: pnode;
	    d_decls: pnode;
	 when n_sents =>
	    s_sent: pnode;
	    s_sents: pnode;
	 when n_ident =>
	    identif: pnode;
	 when n_dec_params =>
	    dpa_param: pnode;
	    dpa_params: pnode;
	 when n_dec_param =>
	    dpa_identif: pnode;
	    dpa_mode: pnode;
	    dpa_tipus: pnode;
	 when n_mode =>
	    mode: t_mode; --TODO revisar, existeix?
	 when n_dec_const =>
	    dc_llista_id: pnode;
	    dc_id_tipus: pnode;
	    dc_vconst: pnode;
	 when n_dec_var =>
	    dv_llista_id: pnode;
	    dv_id_tipus: pnode;
	 when n_dec_array =>
	    da_identif: pnode;
	    da_llista_idx: pnode;
	    da_id_tipus: pnode;
	 when n_dec_rec =>
	    dr_idenfif: pnode;
	    dr_camps: pnode;
	 when dec_subrang =>
	    ds_identif: pnode;
	    ds_id_tipus: pnode;
	    ds_rang: pnode;
	 when n_llista_id =>
	    li_identif: pnode;
	    li_llista_id: pnode;
	 when n_val_const =>
	    vc_signe: t_signe;
	    vc_literal: pnode;
	 when n_vconst =>
	    v_signe: operador; --sols sera menys unitari o nul
	    v_literal: pnode;
	 when n_lit =>
	    l_val: integer; --TODO Revisar i aclarir
	    l_ts: tipus_subjacent;
	 when n_camps_rec =>
	    csr_camp: pnode;
	    csr_llista_camps: pnode;
	 when n_camp_rec =>
	    cr_identif: pnode;
	    cr_id_tipus: pnode;
	 when n_rang =>
	    r_lim_inf: pnode;
	    r_lim_sup: pnode;
	 when n_lim =>
	    lim: pnode;
	 --when n_sent =>
	 when n_sent_buc =>
	    sb_condicio: pnode;
	    sb_sents: pnode;
	 when n_sent_flux =>
	    sb_condicio: pnode;
	    sb_sents: pnode;
	    sb_sents_else: pnode;
	 --when n_sent_proc =>
	 when n_sent_assig =>
	    sa_ref: pnode;
	    sa_expr: pnode;
	 when n_expr =>
	    e_camp1: pnode; --Pot ser expresio, referencia o literal
	    e_operacio: t_operacio;
	    e_camp2: pnode;
	 when n_ref =>
	    r_identif: pnode;
	    r_llista_ref: pnode;
	 when n_ref_comp =>
	    rc_expr: pnode;
	    rc_llista_ref: pnode;
	 when n_identif =>
	    identif: id_nom;
	 when n_lit_enter =>
	    vl: valor;
	 when n_lit_caracter =>
	    caracter: valor;
	 when n_lit_string =>
	    cadena: id_string;
	 end case;
      end record;

   procedure remunta_fill(a: out ast; fill: in ast);

   procedure crea_n_dec_proc(a: out ast;
			     encap, decls, sents, identif: in ast);
   procedure crea_n_encap(a: out ast; identif, params: in ast);
   procedure crea_n_decs(a: out ast; dec, decs: in ast);

   procedure crea_n_sents(a: out ast; sent, sents: in ast);
   procedure crea_n_ident();
   procedure crea_n_dec_params(a: out ast; params, param: in ast);
   procedure crea_n_dec_param(a: out ast;
			      identif, tipus, mode: in ast);
   procedure crea_n_mode(a: out ast; mode: in t_mode);
   procedure crea_n_dec_const(a: out ast; llista_id, valor, tipus: in ast);
   procedure crea_n_dec_var(a: out ast; identif: in id_nom; llista_id: in ast);
   procedure crea_n_dec_array(a: out ast; identif, llista_idx, tipus: in ast);
   procedure crea_n_dec_rec(a: out ast; identif, camps: in ast);
   procedure crea_n_vconst(a: out ast; lit: in ast; signe: in t_operacio);
   procedure crea_n_dec_subrang(a: out ast; identif, tipus, rang: in ast);
   procedure crea_n_llista_id(a:out ast; identif, llista_id: in ast);
   procedure crea_n_camps_rec(a: out ast; camp, camps: in ast);
   procedure crea_n_camp_rec(a: out ast: identif, tipus: in ast);
   procedure crea_n_rang(a: out ast; lim_inf, lim_sup: in ast);
   procedure crea_n_lim(a: out ast; base: in ast ;signe: in t_operacio);
   procedure crea_n_sent_buc(a: out ast; expr, sents: in ast);
   procedure crea_n_sent_flux(a: out ast; expr, sents, sents_else: in ast);
   procedure crea_n_sent_assig(a: out ast; ref, expr: in ast);
   procedure crea_n_expr(a: out ast; expr1, expr2: in ast;
			 operacio: t_operacio);
   procedure crea_n_ref(a:out ast; identif, llista_ref: in ast);
   procedure crea_n_ref_comp(a: out ast; expr, ref_comp: in ast);

end decls.arbre
