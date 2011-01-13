package decls.arbre is



private
   type node;
   type node is access node;
   type tnode is (n_dec_proc, n_encap, n_decs, n_sents, n_ident, n_dec_params,
		  n_dec_param, n_mode, n_dec, n_dec_const, n_dec_var,
		  n_dec_tip, n_dec_array, n_dec_rec, dec_subrang, n_llista_id,
		  n_val_const, n_lit, n_camps_rec, n_camp_rec, n_rang, n_lim,
		  n_sent, n_sent_buc, n_sent_flux, n_sent_proc, n_sent_assig,
		  n_expr, n_ref, n_ref_comp
		  );
   type node (tnd: tnode) is
      record
	 case tnd is
	 when n_dec_proc =>
	    encap: pnode;
	    decls: pnode;
	    sents: pnode;
	    identif: pnode;
	 when n_encap =>

	 when n_decs =>
	 when n_sents =>
	 when n_ident =>
	 when n_dec_params =>
	 when n_dec_param =>
	 when n_mode =>
	 when n_dec =>
	 when n_dec_const =>
	 when n_dec_var =>
	 when n_dec_tip =>
	 when n_dec_array =>
	 when n_dec_rec =>
	 when dec_subrang =>
	 when n_llista_id =>
	 when n_val_const =>
	 when n_lit =>
	 when n_camps_rec =>
	 when n_camp_rec =>
	 when n_rang =>
	 when n_lim =>
	 when n_sent =>
	 when n_sent_buc =>
	 when n_sent_flux =>
	 when n_sent_proc =>
	 when n_sent_assig =>
	 when n_expr =>
	 when n_ref =>
	 when n_ref_comp =>
	 end case;
      end record;







end decls.arbre
