with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;
package body semantica.comprovacio_tipus is

   procedure ct_dec_proc(proc: in ast; error: in out boolean);

   procedure ct_encap(encap: in ast; error: in out boolean) is
   begin
       put("Comprovacio tipus - Encap."); new_line;
   end ct_encap;

	procedure ct_vconst(lit: in ast; tsub: out tipus_sub; v: out valor) is
	begin
		case lit.tnd is 	
			when n_lit_enter => tsub := tsenter; v := lit.vl;
			when n_lit_caracter => tsub := tscar; v := lit.caracter;
			when n_lit_string => put("literal string"); --TODO literal string i booleans???
			when others => null;
		end case;
	end ct_vconst;

	procedure ct_dec_const(const: in ast; error: in out boolean) is
		id_const, id_tipus: id_nom;
		dt, dc: descripcio;
		tsub: tipus_sub;
		v: valor;
		e: boolean;
	begin
		put("Declaracio Constant"); new_line;	
		id_const := const.dc_identif.id;
		id_tipus := const.dc_id_tipus.id;
		dt := cons(ts, id_tipus);
		if dt.td /= d_tipus then
			error := true;
			put("Error: No es una declaracio de tipus"); new_line;
		end if;
		if dt.dt.tsub > tsenter then
			error := true;
			put("Error: Nomes podem tenir constants enteres, booleanes o caracters"); new_line;
		end if; 
		if const.dc_vconst.tnd = n_vconst then
			--Constant amb signe
			--TODO Que feim amb el signe?
			ct_vconst(const.dc_vconst.v_literal, tsub, v); 
		else
			ct_vconst(const.dc_vconst, tsub, v);
		end if;
		if tsub /= dt.dt.tsub then
			error := true;
			put("El valor de la constant no es del tipus que toca."); new_line;
		end if;
		if v < dt.dt.linf or v > dt.dt.lsup then 
			error := true;
			put("El valor de la constant supera els limits"); new_line;
		end if;
		dc := (d_const, id_tipus, v); 
		posa(ts, id_const, dc, e);
		if e then
			error := true;
			put("Ja existeix una constant amb aquest nom"); new_line;
		end if;
	end ct_dec_const;

	procedure ct_dec_variable(var: in ast; error: in out boolean) is
		id_var, id_tipus: id_nom;
		dt, dv: descripcio;	
		e: boolean;
	begin
		id_var := var.dv_id_var.id;
		id_tipus := var.dv_id_tipus.id;
		dt := cons(ts, id_tipus);
		if dt.td /= d_tipus then
			error := true;
			put("Error: No es una declaracio de tipus"); new_line;
		end if;
		nv := nv + 1;
		dv := (d_var, id_tipus, nv);
		posa(ts, id_var, dv, e);
		if e then
			error := true;
			put("Error: Ja existeix una variable amb aquest nom"); new_line;
		end if;
	end ct_dec_variable;

   procedure ct_decs(decs: in ast; error: in out boolean) is
   begin
      if decs.d_decl /= null then
         ct_decs(decs.d_decl, error);
      end if;
      case decs.d_decls.tnd is
         when n_dec_const => ct_dec_const(decs.d_decls, error);
         when n_dec_var => ct_dec_variable(decs.d_decls, error);
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
