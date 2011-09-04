with decls.c3a, decls.generals, decls.descripcions, ada.strings, ada.strings.fixed, ada.strings.maps;
use decls.c3a, decls.generals, decls.descripcions, ada.strings, ada.strings.fixed, ada.strings.maps;
with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
package body semantica.generacio_cintermedi is
	
	--declaracions anticipades
	procedure gci_dec_proc(proc: in ast);
	procedure gci_sents(sents: in ast);

   procedure put_c3a(operador: in integer) is
     var_l : variable;
   begin
     -- si el nom aparaeix a la taula de noms és conegut i l'escrivim tal qual;
     -- en cas contrari posam un text de la forma «tx», on x és el nombre de
     -- l'operand
      var_l := tv(num_var(operador));
      case var_l.t_var is
         when var | par =>
				if var_l.id = idn_nul then
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

   function nova_var return num_var is
   begin
      nv:= nv + 1;
      return nv;
   end nova_var;

   procedure crea_var_temp(t: out num_var) is
      info_var: variable;
   begin
      t:= nova_var;
      info_var:= (var, pila_proc(prof), ocup_int, 0, idn_nul);
      posa_var(tv, t, info_var);
   end crea_var_temp;

   procedure crea_const_num (val: in integer; t: out num_var) is
      info_const: variable;
   begin
      t:= nova_var;
      info_const:= (const, valor(val), tsenter);
      posa_var(tv, t, info_const);
   end crea_const_num;

   procedure genera_ic3a(codi: in inst_c3a; op1, op2, op3: in integer) is
	   inst: ic3a;
	begin
		inst:= (codi, op1, op2, op3);
      escriu_inst(inst);
	end genera_ic3a;

   procedure desp_exp(dexp, rexp: in num_var; t: out num_var) is
   begin
      if dexp = var_nul then
         t:= rexp;
      else
         crea_var_temp(t);
         genera_ic3a(cons_idx, integer(t), integer(rexp), integer(dexp));
      end if;
   end desp_exp;

	procedure gci_identif(id: in ast) is
	begin
		put("Identificador"); new_line; --TODO 
		
--		id:= cons_id(refr);
--      d:= cons(pila_blocs(pila_proc(prof)), id);
--      case d.td is
--        	when d_var =>
--               	tref:= d.tv;
 --                 res:= d.nv;
 --                 desp:= var_nul;
 --              when d_const =>
 --              	res:= nova_var;
 --                 t1:= nova_var;
 --                dt:= cons(pila_blocs(pila_proc(prof)), d.tc);
  --                info_const:= (const, d.vc, dt.dt.tsub);
  --                posa_var(tv, t1, info_const);
  --                crea_var_temp(res);
  --                genera_ic3a(copia, integer(res), integer(t1), op_nul);
  --                tref:= d.tc;
  --                desp:= var_nul;
 --              when d_param =>
 --                 tref:= d.tp;
 --                 res:= d.npar;
 --                 desp:= var_nul;
 --              when others =>
  --                null;
  --       	end case;
	end gci_identif;

	procedure gci_exp(exp: in ast; res, desp: out num_var) is
		rexp_e, rexp_d, desp_idx,
   	t_const, t1, t2, dexp_e, dexp_d: num_var;
      e: num_etq;
      tref: id_nom;
      --ita: it_array;
      info_const: variable;
	begin
		put("Generacio codi intermedi expresio"); new_line;
		case exp.tnd is
	   	when n_lit_enter | n_lit_caracter | n_lit_string => 
				t_const:= nova_var;
				if exp.tnd = n_lit_enter then     
					info_const:= (const, exp.vl, tsenter);
				elsif exp.tnd = n_lit_caracter then
					info_const:= (const, exp.caracter, tscar);
				else 
					--TODO Pensar com resolem exp.cadena. Es un id_string i necesitam un valor
					--info_const:= (const, exp.cadena, tsstr);
					null;
				end if;
	         posa_var(tv, t_const, info_const);
            crea_var_temp(res);
            genera_ic3a(copia, integer(res), integer(t_const), 0);	
			   desp:= var_nul; 
			when n_identif => gci_identif(exp);
 	      when n_ref => put("Referencia"); new_line; --TODO gci_ref();
         when n_ref_comp => put("Referencia composta"); new_line; --TODO gci_ref_comp();
         when n_expr => 
   	      crea_var_temp(res);
   			gci_exp(exp.e_camp1, rexp_e, dexp_e);         
				desp_exp(dexp_e, rexp_e, t1);
				if exp.e_operacio /= o_menys_unitari or exp.e_operacio /= o_not then
   	         gci_exp(exp.e_camp2, rexp_d, dexp_d);
	            desp_exp(dexp_d, rexp_d, t2);
				end if;
            crea_var_temp(res);
				case exp.e_operacio is
	            when o_mes =>
						genera_ic3a(suma, integer(res), integer(t1), integer(t2));
					when o_menys =>
						 genera_ic3a(resta, integer(res), integer(t1), integer(t2));
					when o_producte =>	
						genera_ic3a(mult, integer(res), integer(t1), integer(t2));
					when o_divisio => 
						genera_ic3a(div, integer(res), integer(t1), integer(t2));
					when o_modul =>
                 genera_ic3a(modul, integer(res), integer(t1), integer(t2));                
               when o_and =>
                  genera_ic3a(and_logic, integer(res), integer(t1), integer(t2));
               when o_or =>
                  genera_ic3a(or_logic, integer(res), integer(t1), integer(t2));
					when o_igual =>
						e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_desigual, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_diferent =>
						e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_igual, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_menor =>
						e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_majorig, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_major =>
						e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_menorig, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_menor_igual =>
						e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_major, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_major_igual =>
      		   	e:= nova_etq;
                  genera_ic3a(copia, integer(res), integer(const_fals), op_nul);
                  genera_ic3a(op_menor, integer(e), integer(t1), integer(t2));
                  genera_ic3a(copia, integer(res), integer(const_cert), op_nul);
                  genera_ic3a(etiq, integer(e), op_nul, op_nul);
					when o_menys_unitari => 
						genera_ic3a(resta_unitaria, integer(res), integer(t1), op_nul);
					when o_not => 
						genera_ic3a(not_logic, integer(res), integer(t1), op_nul);
					when others => null;
				end case;
				desp:= var_nul;		
   	   when others => null;
	   end case;
	end gci_exp; 

	procedure gci_sent_buc(buc: in ast) is
      e_ini, e_fi: num_etq;
      exp_r, exp_d: num_var;
   begin
		put("Sent bucle"); new_line;
      e_ini:= nova_etq;
      e_fi:= nova_etq;
      genera_ic3a(etiq, integer(e_ini), op_nul, op_nul);
		gci_exp(buc.sb_condicio, exp_r, exp_d);
      genera_ic3a(op_igual, integer(e_fi), integer(exp_r), integer(const_fals));

		--sentencies bucle
      gci_sents(buc.sb_sents);
      genera_ic3a(goto_op, integer(e_ini), op_nul, op_nul);
      genera_ic3a(etiq, integer(e_fi), op_nul, op_nul);
		put("Fi sent bucle"); new_line;
   end gci_sent_buc;

	procedure gci_sent_fluxe(fluxe: in ast) is
	   e_else, e_fi: num_etq;
	   exp_r, exp_d: num_var:= var_nul;
	begin
		put("Sent fluxe"); new_line;
		gci_exp(fluxe.sf_condicio, exp_r, exp_d);
		e_fi:= nova_etq;     
      if fluxe.sf_sents_else /= null then
			e_else:= nova_etq;
			genera_ic3a(op_igual, integer(e_else), integer(exp_r), integer(const_fals));
			gci_sents(fluxe.sf_sents);
			genera_ic3a(goto_op, integer(e_fi), op_nul, op_nul);
			genera_ic3a(etiq, integer(e_else), op_nul, op_nul);
			gci_sents(fluxe.sf_sents_else);
		else
			genera_ic3a(op_igual, integer(e_fi), integer(exp_r), integer(const_fals));
			gci_sents(fluxe.sf_sents);	 
      end if;		
	end gci_sent_fluxe;

	procedure gci_sent_assig(assig: in ast) is 
		exp_r, exp_d, ref_r, desp_idx,
		ref_d, t: num_var:= var_nul;
		tref: id_nom;
		--ita: it_array;
		info_var: variable;
   begin
		put("Sent assignacio"); new_line;
      --gci_ref(assig.sa_ref, tref, ref_r, desp_idx, ita, ref_d);
      --gci_exp(assig.sa_expr, exp_r, exp_d);
		--if ref_d /= var_nul then
	     -- if exp_d /= var_nul then
	       --  crea_var_temp(t);
	        -- genera_ic3a(cons_idx, integer(t), integer(exp_r), integer(exp_d));
	        -- genera_ic3a(copia_idx, integer(ref_r), integer(ref_d), integer(t));
--         else
  --          genera_ic3a(copia_idx, integer(ref_r), integer(ref_d), integer(exp_r));
    --     end if;
      --else
        -- if exp_d /= var_nul then
          --  genera_ic3a(cons_idx, integer(ref_r), integer(exp_r), integer(exp_d));
--         else
  --          genera_ic3a(copia, integer(ref_r), integer(exp_r), 0);
    --     end if;
      --end if;	
  end gci_sent_assig; 

	procedure gci_sent_proc(proc: in ast; np: out num_proc) is
		--p: param;
	begin
		put("Sent procediment"); new_line; 
		if proc.tnd = n_ref_comp then
			put("Referencia composta"); new_line;
			--noltrus
			--gci_params_proc();
			
			--marc
			--gci_crida_proc(proc.ref_e, np);
         --gci_exp(proc.ref_exp, p.res, p.desp);
         --empila(pila_param, p);
		else
			put("Referencia simple");
			--np:= proc.np;
		end if;
		--mentres no tenguem acabada aquesta funcio posam np = 0 pq no peti. 
		np:= 0;
   end gci_sent_proc;      
 	
	procedure gci_sents(sents: in ast) is
		sent: ast;
		p: param;
   begin	
		if sents.tnd = n_sents then 
         gci_sents(sents.s_sents);
         sent:= sents.s_sent;
      else 
         sent:= sents; 
      end if; 
      case sent.tnd is
         when n_sent_buc => null; --gci_sent_buc(sent);    --TODO descomentar aquests 3 casos
         when n_sent_flux => null; --gci_sent_fluxe(sent);  
         when n_sent_assig => null; --gci_sent_assig(sent);
         when others => 
				gci_sent_proc(sent, np); 
				while not esbuida(pila_param) loop
					p:= cim(pila_param); 
					desempila(pila_param);
					if p.desp = 0 then
						genera_ic3a(params, integer(p.res), op_nul, op_nul);
					else
						genera_ic3a(paramc, integer(p.res), integer(p.desp), op_nul);
					end if;
				end loop;	
				genera_ic3a(call, integer(np), op_nul, op_nul);		
      end case;
	end gci_sents;

	procedure gci_dec_var(v: in ast) is
		id: id_nom; 
		info_var: variable;
	begin
		id:= v.dv_id_var.id;
		info_var:= (var, pila_proc(prof), v.ocup_var, 0, id);
		posa_var(tv, v.nv, info_var);
	end gci_dec_var;

	--TODO Pendent. Mirar apunts perque s'actualitza ts. 		
	procedure gci_idx_array(llista_idx: in ast) is 
		id_idx: id_nom;	
	begin
		if llista_idx.tnd = n_llista_id then	
			gci_idx_array(llista_idx.li_llista_id);			
			id_idx:= llista_idx.li_identif.id;
			--ncomp:= lim_sup - lim_inf + 1;
			--base:= (base* ncomp) + lim_inf;
		else
			id_idx:= llista_idx.id;
			--base:= lim_inf;
		end if;	
	end gci_idx_array;

	procedure gci_dec_array(ar: in ast) is 
		id: id_nom;		
		dt: descripcio;
	begin
		id:= ar.da_identif.id;
   	--dt:= cons(pila_blocs(pila_proc(prof)), id);
		gci_idx_array(ar.da_llista_idx); 
      --dt:= (d_tipus, (tsarray, dt.dt.ocup, dt.dt.tc, base));
      --actualitza(pila_blocs(pila_proc(prof)), id, dt);
	end gci_dec_array;
	
	procedure gci_decls(decls: in ast) is
	begin
		if decls.d_decl /= null then
		   gci_decls(decls.d_decl);
      end if;
		case decls.d_decls.tnd is
         when n_dec_var => gci_dec_var(decls.d_decls);
         when n_dec_array => gci_dec_array(decls.d_decls);
         when n_dec_proc => gci_dec_proc(decls.d_decls);
         when others => null;
      end case;
	end gci_decls;

	procedure gci_dec_params(params: in ast; n_param: in out integer) is
		param: ast;
		id: id_nom; 
		v: variable;
		desp: natural;
	begin
		if params.tnd = n_dec_params then
			gci_dec_params(params.dpa_params, n_param);
			param:= params.dpa_param;
		else	
			param:= params;
		end if;
		id:= param.dpa_identif.id;		
		n_param:= n_param + 1;
		desp:= (n_param * ocup_int) + desp_pila;
		v:= (par, pila_proc(prof), param.ocup_param, desp, id);
		posa_var(tv, param.n_param, v);		
	end gci_dec_params;

	procedure gci_dec_proc(proc: in ast) is
		id: id_nom;
		e: num_etq;
		n_param: natural:= 0;
		p: procediment(intern);
	begin
		id:= proc.dp_identif_inici.id;
		e:= nova_etq;
		prof:= prof + 1;
		pila_proc(prof) := proc.np;  
		if proc.dp_encap /= null then
			gci_dec_params(proc.dp_encap.e_params, n_param);			
		end if;
		p:= (intern, n_param, id, prof, 0, e);
		posa_proc(tp, proc.np, p);
		if proc.dp_decls /= null then
			gci_decls(proc.dp_decls);
		end if;
		genera_ic3a(etiq, integer(e), op_nul, op_nul);
      genera_ic3a(preamb, integer(proc.np), op_nul, op_nul);
	
		if proc.dp_sents /= null then
			gci_sents(proc.dp_sents);
		end if;			
      prof:= prof - 1;
      genera_ic3a(rtn, integer(proc.np), op_nul, op_nul);
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
