with ada.text_io; use ada.text_io;
package semantica.missatges is

   type tipus_md is (inici, fi);

	--missatges d'error
	--procedure me_nom_procediment(idp: in id_nom; p: in posicio);
   --procedure me_decl_param(idt, idpar, idproc: in id_nom; p: in posicio);
   --procedure me_decl_var(idt, idv: in id_nom; p: in posicio);
   --procedure me_decl_const_td(idt, idc: in id_nom; p: in posicio);
   --procedure me_decl_const_ti(idc: in id_nom; p: in posicio);
   --procedure me_decl_const_assig(idc: in id_nom; p: in posicio);
   --procedure me_decl_const_lim(idc: in id_nom; p: in posicio);
   --procedure me_decl_array_index(idi, ida: in id_nom; p: in posicio);
   --procedure me_decl_array_component(idc, ida: in id_nom; p: in posicio);
   --procedure me_decl_rec_tipus(idt, idc, idr: in id_nom; p: in posicio);
   --procedure me_decl_rec_camp(idt, idc, ida: in id_nom; p: in posicio);
   --procedure me_decl_rang_tipus(idt, idr: in id_nom; p: in posicio);
   --procedure me_decl_rang_index(idt, idr: in id_nom; p: in posicio);
   --procedure me_decl_rang_valor(idr: in id_nom; p: in posicio);
   --procedure me_decl_rang_limit(idt, idr: in id_nom; p: in posicio);
   --procedure me_sent_if(p: in posicio);
   --procedure me_sent_while(p: in posicio);
   --procedure me_sent_assig_tipus(idt1, idt2: in id_nom; p: in posicio);
   --procedure me_sent_assig_tipus(idt: in id_nom;
   --                             tsub: in tipus_subj; p: in posicio);
   --procedure me_sent_assig_const(idc: in id_nom; p: in posicio);
   --procedure me_exp_aritm(p: in posicio);
   --procedure me_exp_logic(p: in posicio);
   --procedure me_exp_oprel(p: in posicio);
   --procedure me_ref_id(id: in id_nom; p: in posicio);
   --procedure me_ref_rec(id: in id_nom; p: in posicio);
   --procedure me_ref_camp_rec(idc, idr: in id_nom; p: in posicio);
   --procedure me_ref_proc_id(idp: in id_nom; p: in posicio);
   --procedure me_ref_proc_form(p: in posicio);
   --procedure me_ref_proc_param_insuf(idp: in id_nom; p: in posicio);
   --procedure me_ref_array_index_insuf(ida: in id_nom; p: in posicio);
   --procedure me_ref_proc_param_exc(idp: in id_nom; p: in posicio);
   --procedure me_ref_array_index_exc(ida: in id_nom; p: in posicio);
   --procedure me_ref_array_index_tipus(idi, ida: in id_nom; p: in posicio);
   --procedure me_ref_array_id(id: in id_nom; p: in posicio);
   --procedure me_ref_proc_param_tipus(idpar, idproc: in id_nom; p: in posicio);
   --procedure me_ref_proc_param_mode(idpar, idproc: in id_nom; p: in posicio);

	--missatges de depuracio
	procedure md_dec_param(io: in tipus_md);
	procedure md_dec_params(io: in tipus_md); 
	procedure md_vconst(io: in tipus_md);
	procedure md_dec_const(io: in tipus_md);
   procedure md_dec_variable(io: in tipus_md);
   procedure md_rang(io: in tipus_md); 
	procedure md_dec_subrang(io: in tipus_md);   
   procedure md_idx_array(io: in tipus_md);
	procedure md_dec_array(io: in tipus_md);
	procedure md_camps_rec(io: in tipus_md);
 	procedure md_dec_rec(io: in tipus_md);
	procedure md_decs(io: in tipus_md);
   procedure md_identif(io: in tipus_md);
   procedure md_index(io: in tipus_md);
	procedure md_ref_comp(io: in tipus_md);
   procedure md_ref(io: in tipus_md);
 	procedure md_exp(io: in tipus_md);
	procedure md_sent_buc(io: in tipus_md);
   procedure md_sent_fluxe(io: in tipus_md);
   procedure md_sent_assig(io: in tipus_md); 
	procedure md_param(io: in tipus_md);          
   procedure md_params_proc(io: in tipus_md);
	procedure md_sent_proc(io: in tipus_md);
	procedure md_sents(io: in tipus_md);
	procedure md_dec_proc(io: in tipus_md);    
   procedure md_comprovacio_tipus(io: in tipus_md);

   procedure prepara_log(nom: in string);
   procedure finalitza_log;

private
   --TODO Canviar valor per defecte a false
   mode_depuracio: constant boolean := true;
   mode_log: constant boolean := true;
   log: file_type;
end semantica.missatges;
