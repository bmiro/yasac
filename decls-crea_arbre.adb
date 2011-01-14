package body decls.crea_arbre is

   procedure crea_n_dec_proc(a: out ast; encap, decls, sents, identif: in ast) is
   begin
      a:= new node(n_dec_proc);
      a.dp_encap:= encap;
      a.dp_decls:= decls;
      a.dp_sents:= sents;
      a.dp_identif:= identif;
   end crea_n_dec_proc;

   procedure crea_n_encap(a: out ast; identif, params: in ast) is
   begin
      a:= new node(n_encap);
      a.e_identif:= identif;
      a.e_params:= params;
   end crea_n_encap;

   procedure crea_n_decs(a: out ast; dec, decs: in ast) is
   begin
      a:= new node(n_decs);
      a.d_decl:= dec;
      a.d_decls:= decs;
   end crea_n_decs;

   procedure crea_n_sents(a: out ast; sent, sents: in ast) is
   begin
      a:= new node(n_sents);
      a.s_sent:= sent;
      a.s_sents:= sents;
   end crea_n_sents;

   procedure crea_n_dec_params(a: out ast; params, param: in ast) is
   begin
      a:= new node(n_dec_params);
      a.dpa_params:= params;
      a.dpa_param:= param;
   end crea_n_dec_params;

   procedure crea_n_dec_param(a: out ast; identif, tipus, mode: in ast) is
   begin
      a:= new node(n_dec_param);
      a.dpa_identif:= identif;
      a.dpa_tipus:= tipus;
      a.dpa_mode:= mode;
   end crea_n_dec_param;

   procedure crea_n_mode(a: out ast; mode: in t_mode) is
   begin
      a:= new node(n_mode);
      a.mode:= mode;
   end crea_n_mode;

   procedure crea_n_dec_const(a: out ast; llista_id, valor, tipus: in ast) is
   begin
      a:= new node(n_dec_const);
      a.dc_llista_id:= llista_id;
      a.dc_id_tipus:= tipus;
      a.dc_vconst:= valor;
   end crea_n_dec_const;

   procedure crea_n_dec_var(a: out ast; identif, llista_id: in ast) is
   begin
      a:= new node(n_dec_var);
      a.dv_id_tipus:= identif;
      a.dv_llista_id:= llista_id;
   end crea_n_dec_var;

   procedure crea_n_dec_array(a: out ast; identif, llista_idx, tipus: in ast) is
   begin
		a:= new node(n_dec_array);
      a.da_identif:= identif;
      a.da_llista_idx:= llista_idx;
      a.da_id_tipus:= tipus;
   end crea_n_dec_array;

   procedure crea_n_dec_rec(a: out ast; identif, camps: in ast) is
   begin
      a:= new node(n_dec_rec);
      a.dr_identif:= identif;
      a.dr_camps:= camps;
   end crea_n_dec_rec;

   procedure crea_n_vconst(a: out ast; lit: in ast; signe: in t_operacio) is
   begin
      a:= new node(n_vconst);
      a.v_signe:= signe;
      a.v_literal:= lit;
   end crea_n_vconst;

   procedure crea_n_dec_subrang(a: out ast; identif, tipus, rang: in ast) is
   begin
      a:= new node(dec_subrang);
      a.ds_identif:= identif;
      a.ds_id_tipus:= tipus;
      a.ds_rang:= rang;
   end crea_n_dec_subrang;

   procedure crea_n_llista_id(a: out ast; identif, llista_id: in ast) is
   begin
      a:= new node(n_llista_id);
      a.li_identif:= identif;
      a.li_llista_id:= llista_id;
   end crea_n_llista_id;

   procedure crea_n_camps_rec(a: out ast; camp, camps: in ast) is
   begin
      a:= new node(n_camps_rec);
      a.csr_camp:= camp;
      a.csr_llista_camps:= camps;
   end crea_n_camps_rec;

   procedure crea_n_camp_rec(a: out ast; identif, tipus: in ast) is
   begin
      a:= new node(n_camp_rec);
      a.cr_identif:= identif;
      a.cr_id_tipus:= tipus;
   end crea_n_camp_rec;

   procedure crea_n_rang(a: out ast; lim_inf, lim_sup: in ast) is
   begin
      a:= new node(n_rang);
      a.r_lim_inf:= lim_inf;
      a.r_lim_sup:= lim_sup;
   end crea_n_rang;

   procedure crea_n_lim(a: out ast; base: in ast; signe: in t_operacio) is
   begin
      a:= new node(n_lim);
      a.lim:= base;
      a.signe:= signe;
   end crea_n_lim;

   procedure crea_n_sent_buc(a: out ast; expr, sents: in ast) is
   begin
      a:= new node(n_sent_buc);
      a.sb_condicio:= expr;
      a.sb_sents:= sents;
   end crea_n_sent_buc;

   procedure crea_n_sent_flux(a: out ast; expr, sents, sents_else: in ast) is
   begin
      a:= new node(n_sent_flux);
      a.sf_condicio:= expr;
      a.sf_sents:= sents;
      a.sf_sents_else:= sents_else;
   end crea_n_sent_flux;

   procedure crea_n_sent_assig(a: out ast; ref, expr: in ast) is
   begin
      a:= new node(n_sent_assig);
      a.sa_ref:= ref;
      a.sa_expr:= expr;
   end crea_n_sent_assig;

   procedure crea_n_expr(a: out ast; expr1, expr2: in ast; operacio: t_operacio) is
   begin
      a:= new node(n_expr);
      a.e_camp1:= expr1;
      a.e_operacio:= operacio;
      a.e_camp2:= expr2;
   end crea_n_expr;

   procedure crea_n_ref(a: out ast; identif, llista_ref: in ast) is
   begin
      a:= new node(n_ref);
      a.r_identif:= identif;
      a.r_llista_ref:= llista_ref;
   end crea_n_ref;

   procedure crea_n_ref_comp(a: out ast; expr, ref_comp: in ast) is
   begin
      a:= new node(n_ref_comp);
      a.rc_expr:= expr;
      a.rc_llista_ref:= ref_comp;
   end crea_n_ref_comp;

	procedure remunta_fill(a: out ast; fill: in ast) is
   begin
      a:= fill;
   end remunta_fill;

end decls.crea_arbre;

