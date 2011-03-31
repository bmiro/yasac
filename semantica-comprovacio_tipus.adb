with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;
package body semantica.comprovacio_tipus is

   procedure ct_dec_proc(proc: in ast; error: in out boolean);

   procedure ct_encap(encap: in ast; error: in out boolean) is
   begin
       put("Comprovacio tipus - Encap."); new_line;
   end ct_encap;

	procedure ct_const(const: in ast; error: in out boolean) is
	begin
		new_line;	
		if const.dc_vconst.tnd = n_vconst then
			put("Valor constant amb signe");
		else
			--constant sense signe
			case const.dc_vconst.tnd is
				when n_lit_enter => put(const.dc_vconst.vl'img); 
				when n_lit_caracter => put(const.dc_vconst.caracter'img);
				when n_lit_string => put(con_cad(tn, const.dc_vconst.cadena));
				when others => null;
			end case;
		end if;
		new_line;
	end ct_const;

   procedure ct_decs(decs: in ast; error: in out boolean) is
   begin
      if decs.d_decl /= null then
         ct_decs(decs.d_decl, error);
      end if;
      case decs.d_decls.tnd is
         when n_dec_const => put("Declaracio Constant"); ct_const(decs.d_decls, error);
         when n_dec_var => put("Declaracio Variable"); 
         when n_dec_array => put("Declaracio Array"); 
         when n_dec_rec => put("Declaracio Record"); 
         when n_dec_subrang => put("Declaracio Subrang"); 
         when n_dec_proc => ct_dec_proc(decs.d_decls, error);
         when others => null;
      end case;
		new_line;
   end ct_decs;

   procedure ct_sents(sents: in ast; error: in out boolean) is
      sentencia: ast;
   begin
      put("Comprovacio tipus - Sentencies."); new_line;
   end ct_sents;

   procedure ct_dec_proc(proc: in ast; error: in out boolean) is
      id_inici, id_fi: id_nom;
      e: boolean;
   begin
      put("Declaracio procediment."); new_line;   
      id_inici := proc.dp_identif_inici.id;
      id_fi := proc.dp_identif_fi.id;
      if id_inici /= id_fi then
          error := True;
          put("Nom del procediment diferent"); new_line;
      end if;
      np:= np + 1;      
      posa(ts, id_inici, (d_proc, np), e);
     	if e then
         error:= true;
      end if;
      if proc.dp_encap /= null then
         ct_encap(proc.dp_encap, error);
         entrabloc(ts);
         --primer_index
         --mentres sigui_valid fer
      else
         entrabloc(ts);
      end if;
      if proc.dp_decls /= null then
          ct_decs(proc.dp_decls, error);
      end if;
      if proc.dp_sents /= null then
         ct_sents(proc.dp_sents, error);
      end if;
      surtbloc(ts);
   end ct_dec_proc;
    
   procedure comprova_tipus is
      error: boolean := False;
   begin
      ct_dec_proc(arrel, error);
      if error then
         put("Error semantic");
         new_line;
         raise Error_semantic;
      end if;
   end comprova_tipus;

end semantica.comprovacio_tipus;
