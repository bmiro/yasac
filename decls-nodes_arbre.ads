with decls.generals; use decls.generals;
package decls.nodes_arbre is
   type node;
   type pnode is access node;
	subtype ast is pnode;
   type tnode is (n_dec_proc, n_encap, n_decs, n_sents, n_dec_params,
		  n_dec_param, n_mode, n_dec_const, n_dec_var, n_dec_array,
		  n_dec_rec, dec_subrang, n_llista_id, n_vconst, n_camps_rec,
		  n_camp_rec, n_rang, n_lim,n_sent_buc, n_sent_flux,
		  n_sent_assig, n_expr, n_ref, n_ref_comp, n_identif,
		  n_lit_enter, n_lit_caracter, n_lit_string, n_atom
		  );
   type node (tnd: tnode) is
      record
         lin: natural;
         col: natural;
	 case tnd is
	 when n_dec_proc =>
	    dp_encap: pnode;
	    dp_decls: pnode;
	    dp_sents: pnode;
	    dp_identif: pnode;
	 when n_encap =>
	    e_identif: pnode;
	    e_params: pnode;
	 when n_decs =>
	    d_decl: pnode;
	    d_decls: pnode;
	 when n_sents =>
	    s_sent: pnode;
	    s_sents: pnode;
	 when n_dec_params =>
	    dpa_param: pnode;
	    dpa_params: pnode;
	 when n_dec_param =>
	    dpa_identif: pnode;
	    dpa_mode: pnode;
	    dpa_tipus: pnode;
	 when n_mode =>
	    mode: t_mode;
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
	    dr_identif: pnode;
	    dr_camps: pnode;
	 when dec_subrang =>
	    ds_identif: pnode;
	    ds_id_tipus: pnode;
	    ds_rang: pnode;
	 when n_llista_id =>
	    li_identif: pnode;
	    li_llista_id: pnode;
	 when n_vconst =>
	    v_signe: t_operacio; --sols sera menys unitari o nul
	    v_literal: pnode;
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
		 signe: t_operacio;
	 when n_sent_buc =>
	    sb_condicio: pnode;
	    sb_sents: pnode;
	 when n_sent_flux =>
	    sf_condicio: pnode;
	    sf_sents: pnode;
	    sf_sents_else: pnode;
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
	    id: id_nom;
	 when n_lit_enter =>
	    vl: valor;
	 when n_lit_caracter =>
	    caracter: valor;
	 when n_lit_string =>
	    cadena: id_string;
	 when n_atom =>
            null;
	 end case;
      end record;

end decls.nodes_arbre;
