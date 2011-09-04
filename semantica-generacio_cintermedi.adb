with decls.c3a, decls.generals, decls.descripcions, ada.strings, ada.strings.fixed, ada.strings.maps;
use decls.c3a, decls.generals, decls.descripcions, ada.strings, ada.strings.fixed, ada.strings.maps;
with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
package body semantica.generacio_cintermedi is
	
	--declaracions anticipades
	procedure gci_dec_proc(proc: in ast);

   procedure put_c3a(operador: in integer) is
     var_l : variable;
   begin
     -- si el nom aparaeix a la taula de noms és conegut i l'escrivim tal qual;
     -- en cas contrari posam un text de la forma «tx», on x és el nombre de
     -- l'operand
      var_l := tv(num_var(operador));
      case var_l.t_var is
         when var | par =>
				--TODO Revisar. S'ha de posar id_null, pero no l'agafa
				if var_l.id = 0 then
            	put(ftxt_c3a, "t" & trim(integer'image(operador), both));
            else
            	put(ftxt_c3a, con_id(tn, var_l.id));
            end if;
         when const => put(ftxt_c3a, valor'image(var_l.val));
         when others => null;
      end case;
	   put(ftxt_c3a, "  ");
	end put_c3a;

	procedure put_c3a_etiq(operador: in integer) is
   begin
		put(ftxt_c3a, integer'image(operador));
   	put(ftxt_c3a, ascii.ht);
   end put_c3a_etiq;

   procedure put_c3a_proc(operador: in integer) is
   begin
 		put(ftxt_c3a, integer'image(operador));
   end put_c3a_proc;

	procedure escriu_inst(inst: in ic3a) is
		use decls.c3a.inst_c3a_enum;
   begin
		--fitxer binari
      write(fbin_c3a, inst);

		--fitxer de text
		put(ftxt_c3a, inst.codi);
		put(ftxt_c3a, "    ");
		case inst.codi is
			when cons_idx..or_logic =>
				put_c3a(inst.op1);
				put_c3a(inst.op2);
				put_c3a(inst.op3);
			when op_igual..op_majorig =>
				put_c3a_etiq(inst.op1);
				put_c3a(inst.op2);
				put_c3a(inst.op3);
			when resta_unitaria..paramc =>
				put_c3a(inst.op1);
				put_c3a(inst.op2);
			when etiq..goto_op =>
				put_c3a_etiq(inst.op1);
			when rtn..preamb =>
				put_c3a_proc(inst.op1);
			when others =>
				put_c3a(inst.op1);
		end case;
		new_line(ftxt_c3a);
   end escriu_inst;

   procedure genera_ic3a(codi: in inst_c3a; op1, op2, op3: in integer) is
	   inst: ic3a;
	begin
		inst:= (codi, op1, op2, op3);
      escriu_inst(inst);
   end genera_ic3a;

	--revisar que agafa totes les sentencies correctament
	procedure gci_sents(sents: in ast) is
		sent: ast;
   begin	
		put("Generacio codi intermedi sentencies."); new_line;
		if sents.tnd = n_sents then 
         gci_sents(sents.s_sents);
         sent:= sents.s_sent;
      else 
         sent:= sents; 
      end if; 
      case sent.tnd is
         when n_sent_buc => ada.text_io.put("bucle"); --gci_sent_buc(sent);   
         when n_sent_flux => ada.text_io.put("flux"); --gci_sent_fluxe(sent);  
         when n_sent_assig => ada.text_io.put("assignacio"); --gci_sent_assig(sent);
         when others => ada.text_io.put("procediment"); --gci_sent_proc(sent);  
      end case;
	end gci_sents;
	
	procedure gci_dec_const(const: in ast) is
	begin
		ada.text_io.put("Generacio codi intermedi declaracions constant."); ada.text_io.new_line;
		--TODO Mirar apunts
	end gci_dec_const;
	
	procedure gci_dec_var(v: in ast) is
		id: id_nom; 
		dvar, dt: descripcio;
		info_var: variable;
	begin
		id:= v.dv_id_var.id;
		dvar:= cons(pila_blocs(pila_proc(prof)), id);
		dt:= cons(pila_blocs(pila_proc(prof)), dvar.tyv);
		info_var:= (var, pila_proc(prof), dt.dt.ocup, 0, id);
		posa_var(tv, dvar.nv, info_var);
	end gci_dec_var;

	procedure gci_idx_array(llista_idx: in ast) is 
		id_idx: id_nom;
		dt: descripcio;	
	begin
		if llista_idx.tnd = n_llista_id then	
			--ct_idx_array(llista_idx.li_llista_id, id_array, nc, error);
         id_idx:= llista_idx.li_identif.id;
      else
      	id_idx:= llista_idx.id;
      end if;	
      dt:= cons(ts, id_idx);
	end gci_idx_array;

--if tipus_ast(decl) = llista_indexos then
  --gci_array_idx(decl.index_e, base);
  --idx:= decl.index_id;
  --idi:= cons_id(idx);
  --di:= cons(pila_blocs(pila_proc(prof)), idi);
  --ncomp:= di.dt.lim_sup - di.dt.lim_inf + 1;
  --base:= (base * ncomp) + di.dt.lim_inf;
--else
  --idx:= decl;
  --idi:= cons_id(idx);
  --di:= cons(pila_blocs(pila_proc(prof)), idi);
  --base:= di.dt.lim_inf;
--end if;

	procedure gci_dec_array(ar: in ast) is 
		id: id_nom;		
		dt: descripcio;
	begin
		ada.text_io.put("Generacio codi intermedi declaracions array."); ada.text_io.new_line;
		id:= ar.da_identif.id;
      dt:= cons(pila_blocs(pila_proc(prof)), id);
		--gci_idx_array(ar.da_llista_idx, base); 
      --dt:= (d_tipus, (tsarray, dt.dt.ocup, dt.dt.tc, base));
      --actualitza(pila_blocs(pila_proc(prof)), id, dt);
	end gci_dec_array;

	procedure gci_dec_rec(rec: in ast) is 
	begin
		ada.text_io.put("Generacio codi intermedi declaracions record"); ada.text_io.new_line;
	end gci_dec_rec;

	procedure gci_dec_subrang(subrang: in ast) is
	begin
		ada.text_io.put("Generacio codi intermedi declaracions subrang"); ada.text_io.new_line;
	end gci_dec_subrang;

	procedure gci_decls(decls: in ast) is
	begin
		if decls.d_decl /= null then
		   gci_decls(decls.d_decl);
      end if;
		case decls.d_decls.tnd is
         when n_dec_const =>	gci_dec_const(decls.d_decls); 
         when n_dec_var => gci_dec_var(decls.d_decls);
         when n_dec_array => gci_dec_array(decls.d_decls);
         when n_dec_rec =>	gci_dec_rec(decls.d_decls);	 
         when n_dec_subrang => gci_dec_subrang(decls.d_decls);
         when n_dec_proc => gci_dec_proc(decls.d_decls);
         when others => null;
      end case;
	end gci_decls;

	procedure gci_dec_params(params: in ast; n_param: in out integer) is
		param: ast;
		id: id_nom; 
		v: variable;
		dpar, dt: descripcio;
		desp: integer;
	begin
		if params.tnd = n_dec_params then
			gci_dec_params(params.dpa_params, n_param);
			param:= params.dpa_param;
		else	
			param:= params;
		end if;
		id:= param.dpa_identif.id;	
		dpar:= cons(pila_blocs(pila_proc(prof)), id);
		dt:= cons(pila_blocs(pila_proc(prof)), dpar.tp);
		n_param:= n_param + 1;
		desp:= (n_param * ocup_int) + desp_pila;
		v:= (par, pila_proc(prof), dt.dt.ocup, desp, id);
		posa_var(tv, dpar.n_param, v);		
	end gci_dec_params;

	procedure gci_dec_proc(proc: in ast) is
		dp: descripcio;
		id: id_nom;
		e: num_etq;
		n_param: integer:= 0;
		p: procediment(intern);
	begin
		id:= proc.dp_identif_inici.id;
		dp:= cons(pila_blocs(pila_proc(prof)), id); 
		e:= nova_etq;
		prof:= prof + 1;
		pila_proc(prof) := dp.np; 
		if proc.dp_encap /= null then
			gci_dec_params(proc.dp_encap.e_params, n_param);			
		end if;
		p:= (intern, n_param, id, prof, 0, e);
		posa_proc(tp, dp.np, p);
    
		if proc.dp_decls /= null then
			gci_decls(proc.dp_decls);
		end if;
		--TODO crear variable operador null amb valor = 0, per no posar 0 cada vegada
    	genera_ic3a(etiq, integer(e), 0, 0);
      genera_ic3a(preamb, integer(dp.np), 0, 0);
	
		if proc.dp_sents /= null then
			gci_sents(proc.dp_sents);
		end if;			
      prof:= prof - 1;
      genera_ic3a(rtn, integer(dp.np), 0, 0);
	end gci_dec_proc;
     
	procedure inicialitza_generacio_cintermedi is
		info_const: variable;
   begin
		pbuida(pila_param);
		pila_proc(prof):= 0;
		info_const:= (const, 0, tsenter);
		nv:= nv + 1;
		const_fals:= nv;
		posa_var(tv, const_fals, info_const);
		info_const:= (const, -1, tsenter);
		nv:= nv + 1;
		const_cert:= nv;
		posa_var(tv, const_cert, info_const);
	end inicialitza_generacio_cintermedi;
	
	procedure prepara_c3a(nom: in string) is
   begin
   	c3a_bin.create(fbin_c3a, c3a_bin.inout_file, nom & ".c3ab");
   	ada.text_io.create(ftxt_c3a, ada.text_io.out_file, nom & ".c3at");
   end prepara_c3a;

   procedure finalitza_c3a is
   begin
      c3a_bin.close(fbin_c3a);
   	ada.text_io.close(ftxt_c3a);
   end finalitza_c3a;

	procedure genera_cintermedi(nom: in string) is
		info_const: variable;
	begin
		prepara_c3a(nom);
		inicialitza_generacio_cintermedi;
      gci_dec_proc(arrel);
      --assign_despl;
      finalitza_c3a;
	end genera_cintermedi;
	
end semantica.generacio_cintermedi;
