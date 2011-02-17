with ada.integer_text_io; use ada.integer_text_io;
package body semantica.comprovacio_tipus is

	procedure ct_proc(proc: in ast; error: in out boolean) is
		id_inici, id_fi: id_nom;
	begin
		put("Comprovacio tipus proc"); new_line;	
		id_inici := proc.dp_identif_inici.id;
		id_fi := proc.dp_identif_fi.id;
		put(id_inici'img);
		put(id_fi'img);
		put(con_id(tn, id_inici)); new_line;
		put(con_id(tn, id_fi)); new_line;
		if id_inici /= id_fi then
			error := True;
			put("Nom del procediment diferent"); new_line;
		end if;
	end ct_proc;
	
   procedure comprova_tipus is
		error: boolean := False;
	begin
		ct_proc(arrel, error);
		if error then
			put("Error semantic");
			new_line;
			raise Error_semantic;
		end if;
	end comprova_tipus;

end semantica.comprovacio_tipus;
