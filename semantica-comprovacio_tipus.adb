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
			ct_decs(decs.d_decl, error);
		else
			case decs.d_decls.tnd is
				when n_dec_const => put("Constant"); new_line;
				when n_dec_var => put("Variable"); new_line;
				when n_dec_array => put("Array"); new_line;
				when n_dec_rec => put("Record"); new_line;
				when n_dec_subrang => put("Subrang"); new_line;
				when n_dec_proc => put("Procediment"); new_line;
				when others => null;
			end case;
		end if;
	end ct_decs;

	procedure ct_sent(sent: in ast; error: in out boolean) is
	begin
		case sent.tnd is
			when n_sent_buc => put("Bucle"); new_line;
			when n_sent_flux => put("IF"); new_line;
			--when n_sent_proc => put("Sent procedure"); new_line;
			when n_sent_assig => put("Assignacio"); new_line;
			when others => null;
		end case;
	end ct_sent;

	procedure ct_sents(sents: in ast; error: in out boolean) is
		sentencia: ast;
	begin
		put("Comprovacio tipus - Sentencies."); new_line;
		if sents.s_sents.tnd = n_sents then
			ct_sents(sents.s_sents, error);
			sentencia:= sents.s_sent;
		else
			ct_sent(sents.s_sent, error);
			sentencia:= sents.s_sents;
		end if;
		ct_sent(sentencia, error);
	end ct_sents;

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
		--posa_s(ts, id_inici, (d_proc, np), e);
      --if e then
      --   put("Ja existeix un procediment amb aquest nom");
      --   error:= true;
      --end if;
		if proc.dp_encap /= null then
		    ct_encap(proc.dp_encap, error);
		end if;
		if proc.dp_decls /= null then
		    ct_decs(proc.dp_decls, error);
		end if;
		if proc.dp_sents /= null then
			ct_sents(proc.dp_sents, error);
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
