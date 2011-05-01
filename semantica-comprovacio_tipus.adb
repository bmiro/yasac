with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;
package body semantica.comprovacio_tipus is

   procedure ct_dec_proc(proc: in ast; error: in out boolean);

	procedure ct_param(param: in ast; id_proc: in id_nom; error: in out boolean) is
		id_param, id_tipus : id_nom;
		mode : t_mode;
		dt, dp : descripcio;
		e : boolean;
	begin
		id_param := param.dpa_identif.id;
		id_tipus := param.dpa_tipus.id;
		mode := param.dpa_mode.mode;
		dt := cons(ts, id_tipus);
		if dt.td /= d_tipus then
			error := true;
			put("Error: El tipus del parametre "); put(con_id(tn, param.dpa_identif.id)); put(" es incorrecte"); new_line;
		end if;
		dp := (d_param, id_tipus, mode, 0); 
		posa_param(ts, id_proc, id_param, dp, e);
		if e then 
			error := true;
			put("Error: Ja existeix un parametre amb aquest nom"); new_line;
		end if;
	end ct_param;

   procedure ct_params(params: in ast; id_proc: in id_nom; error: in out boolean) is
   begin   
		if params.tnd = n_dec_params then
			ct_params(params.dpa_params, id_proc, error);
			ct_param(params.dpa_param, id_proc, error);
		else 
			ct_param(params, id_proc, error);
		end if;
	end ct_params;

	--TODO Canviar nom a aquest procediment
	procedure ct_vconst(lit: in ast; tsub: out tipus_sub; v: out valor) is
	begin
		case lit.tnd is 	
			when n_lit_enter => tsub := tsenter; v := lit.vl;
			when n_lit_caracter => tsub := tscar; v := lit.caracter;
			--TODO booleans?
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
			ct_vconst(const.dc_vconst.v_literal, tsub, v);
			if tsub /= tsenter then
				error := true; 
				put("Error: Signe menys incompatible amb el tipus."); new_line;
			end if; 
			v := -v;
		else
			ct_vconst(const.dc_vconst, tsub, v);
		end if;
		if tsub /= dt.dt.tsub then
			error := true;
			put("Error: El valor de la constant no es del tipus que toca."); new_line;
		end if;
		if tsub = tsenter or tsub = tscar then
			if v < dt.dt.linf or v > dt.dt.lsup then 
				error := true;
				put("Error: El valor de la constant supera els limits"); new_line;
			end if;
		end if;
		dc := (d_const, id_tipus, v); 
		posa(ts, id_const, dc, e);
		if e then
			error := true;
			put("Error: Nom de la constant incorrecte"); new_line;
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
			put("Error: Nom de la variable incorrecte"); new_line;
		end if;
	end ct_dec_variable;

	procedure ct_rang(rang: in ast; tsub: out tipus_sub; v: out valor; error: in out boolean) is
	begin
		if rang.tnd = n_lim then			
			--Limit amb signe
			ct_vconst(rang.lim, tsub, v);
			if tsub /= tsenter then
				error := true; 
				put("Error: Signe menys incompatible amb el tipus."); new_line;
			end if; 
			v := -v;
		else 
			ct_vconst(rang, tsub, v);
		end if;
	end ct_rang;

	procedure ct_dec_subrang(subrang: in ast; error: in out boolean) is
		id_subrang, id_tipus : id_nom; 
		dt : descripcio;
		tsub_inf, tsub_sup: tipus_sub;
		v_inf, v_sup : valor;
		e : boolean;
	begin
		id_subrang := subrang.ds_identif.id;
		id_tipus := subrang.ds_id_tipus.id;
		dt := cons(ts, id_tipus); 
		if dt.td /= d_tipus then
			error := true;
			put("Error: No es una declaracio de tipus"); new_line;
		end if;
		if dt.dt.tsub > tsenter then
			error := true;
			put("Error: No es un escalar"); new_line;
		end if;
		ct_rang(subrang.ds_rang.r_lim_inf, tsub_inf, v_inf, error);
		ct_rang(subrang.ds_rang.r_lim_sup, tsub_sup, v_sup, error);			
		if tsub_inf /= dt.dt.tsub then
			error := true;
			put("Error: Tipus del valor inferior incorrecte"); new_line;
		end if;
		if tsub_sup /= dt.dt.tsub then
			error := true;
			put("Error: Tipus del valor superior incorrecte"); new_line;
		end if;
		if v_inf < dt.dt.linf then 
			error := true;
			put("Error: El valor inferior supera els limits"); new_line;
		end if;
		if v_sup > dt.dt.lsup then 
			error := true;
			put("Error: El valor superior supera els limits"); new_line;
		end if;
		if v_inf > v_sup then
			error := true; 
			put("Error: El valor inferior es major que el superior"); new_line;
		end if;
		case dt.dt.tsub is 
			when tsenter => dt := (d_tipus, (tsenter, dt.dt.ocup, v_inf, v_sup, id_tipus)); --TODO Aclarir quin id posar
			when others => null;
		end case;
		posa(ts, id_subrang, dt, e);
		if e then
			error := true;
			put("Error"); new_line;
		end if;
	end ct_dec_subrang;

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
         when n_dec_subrang => ct_dec_subrang(decs.d_decls, error);
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
      id_inici, id_fi, id_param : id_nom;
		d_param : descripcio;
		it : it_param;
      e: boolean;
   begin   
      id_inici := proc.dp_identif_inici.id;
      id_fi := proc.dp_identif_fi.id;
      if id_inici /= id_fi then
          error := True;
          put("Error: Nom del procediment diferent"); new_line;
      end if;
      np := np + 1;      
      posa(ts, id_inici, (d_proc, np), e);
     	if e then
         error:= true;
      end if;
      if proc.dp_encap /= null then
         ct_params(proc.dp_encap.e_params, id_inici, error);
         entrabloc(ts);
    		it := primer_param(ts, id_inici);
			while esvalid(it) loop 
				cons_param(ts, it, id_param, d_param);
				nv := nv + 1;
				d_param.n_param := nv;
				posa(ts, id_param, d_param, e);
				it := seg_param(ts, it);
			end loop;
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
