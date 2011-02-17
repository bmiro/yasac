with ada.integer_text_io; use ada.integer_text_io;
package body semantica.comprovacio_tipus is

	procedure ct_encap(encap: in ast; error: in out boolean) is
	begin
	    put("Comprovacio tipus - Encap."); new_line;
	end ct_encap;

	procedure ct_decs(decs: in ast; error: in out boolean) is
	begin
	    put("Comprovacio tipus - Declaracions."); new_line;
	    if decs.d_decl /= null then
		put("Hi ha mes d'una declaracio"); new_line;
	    else
		put("Nomes tenim una declaracio"); new_line;
	    end if;
	end ct_decs;

	procedure ct_dec_proc(proc: in ast; error: in out boolean) is
		id_inici, id_fi: id_nom;
	begin
		put("Comprovacio tipus - Declaracio procediment."); new_line;	
		id_inici := proc.dp_identif_inici.id;
		id_fi := proc.dp_identif_fi.id;
		if id_inici /= id_fi then
		    error := True;
		    put("Nom del procediment diferent"); new_line;
		end if;
		if proc.dp_encap /= null then
		    put("El procediment te parametres"); new_line;
		    ct_encap(proc.dp_encap, error);
		else
		    put("El procediment no te parametres"); new_line;
		end if;
		if proc.dp_decls /= null then
		    put("El procediment te declaracions"); new_line;
		    ct_decs(proc.dp_decls, error);
		else
		    put("El procediment no te declaracionss"); new_line;
		end if;
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
