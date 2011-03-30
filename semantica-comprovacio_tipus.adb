with ada.integer_text_io; use ada.integer_text_io;
package body semantica.comprovacio_tipus is

	procedure ct_dec_proc(proc: in ast; error: in out boolean);

	procedure ct_encap(encap: in ast; error: in out boolean) is
	begin
	    put("Comprovacio tipus - Encap."); new_line;
	end ct_encap;

	procedure ct_decs(decs: in ast; error: in out boolean) is
	begin
		if decs.d_decl /= null then
			ct_decs(decs.d_decl, error);
		end if;
		case decs.d_decls.tnd is
			when n_dec_const => put("Declaracio Constant"); new_line;
			when n_dec_var => put("Declaracio Variable"); new_line;
			when n_dec_array => put("Declaracio Array"); new_line;
			when n_dec_rec => put("Declaracio Record"); new_line;
			when n_dec_subrang => put("Declaracio Subrang"); new_line;
			when n_dec_proc => ct_dec_proc(decs.d_decls, error);
			when others => null;
		end case;
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
      	put("Ja existeix un procediment amb aquest nom"); new_line;
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
