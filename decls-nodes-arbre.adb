package body decls.nodes-arbre is

	procedure crea_n_dec_proc(a: out ast; encap, decls, sents: in ast; identif: in id_nom) is
	begin
		a := new node(n_dec_proc);
		a.dp_encap := encap;		
		a.dp_decls := decls;
		a.dp_sents := sents;
		a.dp_identif := identif;
	end crea_n_dec_proc;

	procedure crea_n_encap(a: out ast; identif: in id_nom; params: in ast) is
	begin
		a := new node(n_encap);
		a.e_identif := identif;
		a.e_params := params;
	end crea_n_encap;

	procedure crea_n_decs(a: out ast; dec, decs: in ast) is 
	begin
		a := new node(n_decs);
		a.d_decl := dec;
		a.d_decls := decs;
	end crea_n_decs;

	procedure remunta_decs(a: out ast) is
	begin
		a := null;
	end remunta_decs;
	
	procedure remunta_dec(a: out ast; dec_especifica: in ast) is
	begin
		a := dec_especifica;
	end remunta_dec;

   --procedure crea_n_sents() is
	--begin
	--end crea_n_sents;

   --procedure crea_n_ident() is
	--begin
	--end crea_n_ident;

   procedure crea_n_dec_params(a: out ast; params, param: in ast) is
	begin
		a := new node(n_dec_params);
		a.dpa_params := params;
		a.dpa_param := param;
	end crea_n_dec_params;

   procedure crea_n_dec_param(a: out ast; identif, tipus: in id_nom; mode: in pnode) is
	begin
		a := new node(n_dec_param);
		a.dpa_identif := identif;
		a.dpa_tipus := tipus;
		a.dpa_mode := mode;		
	end crea_n_dec_param;

   procedure crea_n_mode(a: out ast; mode: in t_mode) is
	begin
		a := new node(n_mode);
		a.mode := mode;
	end crea_n_mode;	


   procedure crea_n_dec_const(a: out ast; llista_id, valor: in ast; tipus: in id_nom) is
	begin 
		a := new node(n_dec_const);
		a.dc_llista_id := llista_id;
		a.dc_id_tipus := tipus;
		a.dc_vconst := valor;
	end crea_n_dec_const;

end decls.nodes-arbre;
