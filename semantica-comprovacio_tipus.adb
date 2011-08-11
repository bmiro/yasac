   with ada.integer_text_io; use ada.integer_text_io;
   package body semantica.comprovacio_tipus is

	--declaracions anticipades
	procedure ct_dec_param(param: in ast; id_proc: in id_nom; 
				 				  	error: in out boolean);
	procedure ct_dec_params(params: in ast; id_proc: in id_nom; 
									error: in out boolean); 
   procedure ct_vconst(lit: in ast; tsub: out tipus_sub; v: out valor);
	procedure ct_dec_const(const: in ast; error: in out boolean);
   procedure ct_dec_variable(var: in ast; error: in out boolean);
   procedure ct_rang(rang: in ast; tsub: out tipus_sub; v: out valor; 
									error: in out boolean);
	procedure ct_dec_subrang(subrang: in ast; error: in out boolean);   
   procedure ct_idx_array(llista_idx: in ast; id_array: in id_nom;
	                          nc: in out valor; error: in out boolean);	
   procedure ct_dec_array(ar: in ast; error: in out boolean);
	procedure ct_camps_rec(camps: in ast; id_rec: in id_nom;
 	                         ocup: in out natural; error: in out boolean);
	procedure ct_dec_rec(rec: in ast; error: in out boolean);
	procedure ct_decs(decs: in ast; error: in out boolean);
   procedure ct_identif(id: in ast; t: out id_nom; tsub: out tipus_sub;
    	                    var, error: in out boolean);  
	procedure ct_index(it: it_index; texpr: in id_nom; tsexpr: in tipus_sub;
	                      error: in out boolean);
	procedure ct_ref_comp(ref_comp: in ast; t: out id_nom; tsub: out tipus_sub;
                            it: out it_index; var, error: in out boolean);
   procedure ct_ref(ref: in ast; t: out id_nom; tsub: out tipus_sub;
 	                    var, error: in out boolean);
	procedure ct_exp(exp: in ast; t: out id_nom; tsub: out tipus_sub;
	                    v: out valor; var, error: in out boolean);
	procedure ct_sent_buc(buc: in ast; error: in out boolean);
   procedure ct_sent_fluxe(fluxe: in ast; error: in out boolean);
   procedure ct_sent_assig(assig: in ast; error: in out boolean); 
	procedure ct_param(it: it_param; texpr: in id_nom; tsexpr: in tipus_sub;
	                      var, error: in out boolean);          
   procedure ct_params_proc(params: in ast; t: out id_nom; tsub: out tipus_sub;
	                            it: out it_param; var, error: in out boolean);
	procedure ct_sent_proc(sent: in ast; error: in out boolean);
	procedure ct_sents(sents: in ast; error: in out boolean);
	procedure ct_dec_proc(proc: in ast; error: in out boolean);     
   

   procedure ct_dec_param(param: in ast; id_proc: in id_nom;
                          error: in out boolean) is
      id_param, id_tipus: id_nom;
      mode: t_mode;
      dt, dp: descripcio;
      e: boolean;
      error_param: exception;
   begin
      id_param:= param.dpa_identif.id;
      id_tipus:= param.dpa_tipus.id;
      mode:= param.dpa_mode.mode;
      dt:= cons(ts, id_tipus);
      if dt.td /= d_tipus then
         put("Error: El tipus del parametre '");
         put(con_id(tn, param.dpa_identif.id));
         put("' es incorrecte."); 
         raise error_param;
      end if;
      dp:= (d_param, id_tipus, mode, 0); 
      posa_param(ts, id_proc, id_param, dp, e);
      if e then 
         put("Error: Conflicte amb el nom '");
         put(con_id(tn, id_param));
         put("'. "); 
         raise error_param;
      end if;
      exception
         when error_param =>
            error:= true;
            new_line;
   end ct_dec_param;

   procedure ct_dec_params(params: in ast; id_proc: in id_nom;
                           error: in out boolean) is
   begin   
      if params.tnd = n_dec_params then
         ct_dec_params(params.dpa_params, id_proc, error);
         ct_dec_param(params.dpa_param, id_proc, error);
      else 
         ct_dec_param(params, id_proc, error);
      end if;
   end ct_dec_params;

   procedure ct_vconst(lit: in ast; tsub: out tipus_sub; v: out valor) is
   begin
      case lit.tnd is 	
         when n_lit_enter => 
            tsub:= tsenter; 
            v:= lit.vl;			
         when n_lit_caracter => 
            tsub:= tscar; 
            v:= lit.caracter;
         when others => null;
      end case;
   end ct_vconst;

   procedure ct_dec_const(const: in ast; error: in out boolean) is
      id_const, id_tipus: id_nom;
      dt, dc: descripcio;
      tsub: tipus_sub;
      v: valor;
      e: boolean;
      error_dec_const: exception; 
   begin	
      id_const:= const.dc_identif.id;
      id_tipus:= const.dc_id_tipus.id;
      dt:= cons(ts, id_tipus);
      if dt.td /= d_tipus then
         put("Error: Tipus de la constant '");
         put(con_id(tn, id_const));
         put("' incorrecte. "); 
         raise error_dec_const;		
      end if;
      if dt.dt.tsub > tsenter then
         put("Error: Nomes podem tenir constants enteres o caracters. "); 
         raise error_dec_const;
      end if; 
      if const.dc_vconst.tnd = n_vconst then
         --Constant amb signe	
         ct_vconst(const.dc_vconst.v_literal, tsub, v);
         if tsub /= tsenter then
            put("Error: Signe menys de la constant incompatible amb el tipus. ");
            raise error_dec_const;		
         end if; 
         v:= -v;
      else
         ct_vconst(const.dc_vconst, tsub, v);
      end if;
      if tsub /= dt.dt.tsub then
         put("Error: El valor de la constant no es del tipus que toca. "); 
         raise error_dec_const;		
      end if;
      if tsub = tsenter or tsub = tscar then
         if v < dt.dt.linf or v > dt.dt.lsup then 
            put("Error: El valor de la constant supera els limits. "); 
            raise error_dec_const;
         end if;
      end if;
      dc:= (d_const, id_tipus, v); 
      posa(ts, id_const, dc, e);
      if e then
         put("Error: Conflicte amb el nom '");
         put(con_id(tn, id_const));
         put("'. "); 
         raise error_dec_const;
      end if;

      exception
         when error_dec_const => 
            error:= true;
            new_line;
   end ct_dec_const;

   procedure ct_dec_variable(var: in ast; error: in out boolean) is
      id_var, id_tipus: id_nom;
      dt, dv: descripcio;	
      e: boolean;
      error_dec_variable: exception; 
   begin
      id_var:= var.dv_id_var.id;
      id_tipus:= var.dv_id_tipus.id;
      dt:= cons(ts, id_tipus);
      if dt.td /= d_tipus then
         put("Error: Tipus de la variable '");
         put(con_id(tn, id_var));
         put("' incorrecte. "); 
         raise error_dec_variable; 	
      end if;
      nv:= nv + 1;
      dv:= (d_var, id_tipus, nv);
      posa(ts, id_var, dv, e);
      if e then		
         put("Error: Conflicte amb el nom '");
         put(con_id(tn, id_var));
         put("'. ");
         raise error_dec_variable;		
      end if;

      exception
         when error_dec_variable => 
            error:= true; 
            new_line;
   end ct_dec_variable;

   procedure ct_rang(rang: in ast; tsub: out tipus_sub;
                     v: out valor; error: in out boolean) is
      error_rang: exception;	
   begin
      if rang.tnd = n_lim then			
         --Limit amb signe
         ct_vconst(rang.lim, tsub, v);
         if tsub /= tsenter then
            put("Error: Signe menys incompatible amb el tipus del rang. "); 
            raise error_rang; 
         end if; 
         v:= -v;
      else 
         ct_vconst(rang, tsub, v);
      end if;

      exception 
         when error_rang => 
            error:= true; 
            new_line;
   end ct_rang;

   procedure ct_dec_subrang(subrang: in ast; error: in out boolean) is
      id_subrang, id_tipus: id_nom; 
      dt: descripcio;
      tsub_inf, tsub_sup: tipus_sub;
      v_inf, v_sup : valor;
      e : boolean;
      error_dec_subrang : exception; 		
   begin
      id_subrang:= subrang.ds_identif.id;
      id_tipus:= subrang.ds_id_tipus.id;
      dt:= cons(ts, id_tipus); 
      if dt.td /= d_tipus then
         put("Error: Tipus del subrang '"); put(con_id(tn, id_subrang));
         put("' incorrecte. "); 
         raise error_dec_subrang; 
      end if;
      if dt.dt.tsub > tsenter then
         put("Error: No es un escalar. "); 
         raise error_dec_subrang; 
      end if;
      ct_rang(subrang.ds_rang.r_lim_inf, tsub_inf, v_inf, error);
      ct_rang(subrang.ds_rang.r_lim_sup, tsub_sup, v_sup, error);			
      if tsub_inf /= dt.dt.tsub then
         put("Error: Tipus del valor inferior incorrecte. "); 
         raise error_dec_subrang; 
      end if;
      if tsub_sup /= dt.dt.tsub then
         put("Error: Tipus del valor superior incorrecte. "); 
         raise error_dec_subrang; 
      end if;
      if v_inf < dt.dt.linf then 
         put("Error: El valor inferior supera els limits. "); 
         raise error_dec_subrang; 
      end if;
      if v_sup > dt.dt.lsup then 
         put("Error: El valor superior supera els limits. "); 
         raise error_dec_subrang; 
      end if;
      if v_inf > v_sup then
         put("Error: El valor inferior es major que el superior. "); 
         raise error_dec_subrang; 		
      end if;
      case dt.dt.tsub is 
         when tsenter => dt:= (d_tipus,
                              (tsenter, dt.dt.ocup, v_inf, v_sup, id_tipus));
         when tscar => dt:= (d_tipus,
                            (tscar, dt.dt.ocup, v_inf, v_sup, id_tipus));
         when others => null;
      end case;
      posa(ts, id_subrang, dt, e);
      if e then
         put("Error: Conflicte amb el nom '"); put(con_id(tn, id_subrang));
         put("'. ");			
         raise error_dec_subrang; 		
      end if;

      exception
         when error_dec_subrang => 
            error:= true; 
            new_line;
   end ct_dec_subrang;

   procedure ct_idx_array(llista_idx: in ast; id_array: in id_nom;
                          nc: in out valor; error: in out boolean) is
      id_idx: id_nom;
      dt: descripcio;
      error_idx_array: exception; 
   begin
      if llista_idx.tnd = n_llista_id then	
         ct_idx_array(llista_idx.li_llista_id, id_array, nc, error);
         id_idx:= llista_idx.li_identif.id;
      else
         id_idx:= llista_idx.id;
      end if;	
      dt:= cons(ts, id_idx);
      if not (dt.td = d_tipus and then dt.dt.tsub <= tsenter) then			
         put("Error: Tipus de l'index '"); put(con_id(tn, id_idx));
         put("' incorrecte. "); 
         raise error_idx_array; 
      end if;
      posa_index(ts, id_array, id_idx);
      nc:= nc * (dt.dt.lsup - dt.dt.linf + 1);

      exception
         when error_idx_array => 
            error:= true; 
            new_line;
   end ct_idx_array; 

   procedure ct_dec_array(ar: in ast; error: in out boolean) is
      id_array, id_tipus: id_nom;
      d, dt: descripcio;	
      da: descr_tipus;		
      e: boolean;
      nc: valor := 1; 
      error_dec_array: exception; 
   begin
      id_array:= ar.da_identif.id;
      id_tipus:= ar.da_id_tipus.id;			
      dt:= cons(ts, id_tipus); 
      if dt.td /= d_tipus then
         put("Error: Tipus de l'array '"); put(con_id(tn, id_array));
         put("' incorrecte. "); 
         raise error_dec_array; 		
      end if;
      da:= (tsarray, 0, id_tipus);
      d:= (d_tipus, da); 
      posa(ts, id_array, d, e); 
      if e then
         put("Error: Conflicte amb el nom '"); put(con_id(tn, id_array));
         put("'. "); 
         raise error_dec_array; 		
      end if;
      ct_idx_array(ar.da_llista_idx, id_array, nc, error); 
      da.ocup:= natural(nc) * dt.dt.ocup;	
      d:= (d_tipus, da);		
      actualitza(ts, id_array, d);

      exception
         when error_dec_array => 
            error:= true; 
            new_line;
   end ct_dec_array;

   procedure ct_camps_rec(camps: in ast; id_rec: in id_nom;
                          ocup: in out natural; error: in out boolean) is
      id_camp, id_tipus: id_nom;
      dt, dc: descripcio;  
      e: boolean; 
      error_record: exception; 
   begin
      if camps.tnd = n_camps_rec then
         ct_camps_rec(camps.csr_llista_camps, id_rec, ocup, error); 
         id_camp:= camps.csr_camp.cr_identif.id;
         id_tipus:= camps.csr_camp.cr_id_tipus.id;
      else
         id_camp:= camps.cr_identif.id;
         id_tipus:= camps.cr_id_tipus.id;
      end if;
      dt:= cons(ts, id_tipus); 
      if dt.td /= d_tipus then	
         put("Error: Tipus del camp del record '"); put(con_id(tn, id_camp));
         put("' incorrecte. "); 
         raise error_record;		
      end if;
      if id_rec = id_tipus then 
         put("Error: Tipus del camp del record'"); put(con_id(tn, id_camp));
         put("' incorrecte. ");  
         raise error_record;
      end if; 
      dc:= (d_camp, ocup, id_tipus);
      posa_camp(ts, id_rec, id_camp, dc, e);  
      if e then			
         put("Error: Conflicte amb el nom '"); put(con_id(tn, id_camp));
         put("'. "); 			
         raise error_record;
      end if; 
      ocup:= ocup + dt.dt.ocup;		
      exception
         when error_record =>
            error:= true;
            new_line;
   end ct_camps_rec; 

   procedure ct_dec_rec(rec: in ast; error: in out boolean) is
      id_rec: id_nom;
      d: descripcio; 
      dr: descr_tipus;
      ocup: natural := 0; 
      e: boolean; 
      error_dec_rec: exception;
   begin
      id_rec:= rec.dr_identif.id;
      dr:= (tsrec, 0);
      d:= (d_tipus, dr);
      posa(ts, id_rec, d, e); 
      if e then
         put("Error: Conflicte amb el nom '"); put(con_id(tn, id_rec));
         put("'. "); 
         raise error_dec_rec; 
      end if;
      ct_camps_rec(rec.dr_camps, id_rec, ocup, error);
      dr:= (tsrec, ocup);
      d:= (d_tipus, dr);
      actualitza(ts, id_rec, d); 
      exception 
         when error_dec_rec => 
            error:= true; 
            new_line;
   end ct_dec_rec; 

   procedure ct_decs(decs: in ast; error: in out boolean) is
   begin
      if decs.d_decl /= null then
         ct_decs(decs.d_decl, error);
      end if;
      case decs.d_decls.tnd is
         when n_dec_const => ct_dec_const(decs.d_decls, error);
         when n_dec_var => ct_dec_variable(decs.d_decls, error);
         when n_dec_array => ct_dec_array(decs.d_decls, error);
         when n_dec_rec => ct_dec_rec(decs.d_decls, error);  
         when n_dec_subrang => ct_dec_subrang(decs.d_decls, error);
         when n_dec_proc => ct_dec_proc(decs.d_decls, error);
         when others => null;
      end case;
   end ct_decs;

   procedure ct_identif(id: in ast; t: out id_nom; tsub: out tipus_sub;
                        var, error: in out boolean) is
      id_tipus: id_nom; 
      d, dt: descripcio; 	
   begin 
      id_tipus:= id.id;
      dt:= cons(ts, id_tipus); 
      case dt.td is 
         when d_var =>  
            d:= cons(ts, dt.tyv); 
            t:= dt.tyv;
            tsub := d.dt.tsub; 
            var:= true; 
         when d_const => 
            d:= cons(ts, dt.tyc); 
            t:= dt.tyc;	
            tsub:= d.dt.tsub;
            var:= false;
         when d_param => 
            d:= cons(ts, dt.tp); 
            t:= dt.tp;
            tsub:= d.dt.tsub;
            if dt.mode = m_in then
               var:= false; 
            else 
               var:= true; 	
            end if; 
         when d_camp => 
            d:= cons(ts, dt.tc); 
            t:= dt.tc;
            tsub:= d.dt.tsub; 
            var:= true;			
         when others => 
            put("Error: L'identificador '"); put(con_id(tn, id.id));
            put("' no existeix. "); new_line;
            error := true; 
      end case;  
   end ct_identif; 

   procedure ct_index(it: it_index; texpr: in id_nom; tsexpr: in tipus_sub;
                      error: in out boolean) is
      id_tipus_index: id_nom;		
      d: descripcio; 
      error_index: exception;
   begin 
      id_tipus_index:= cons_index(ts, it);
      if texpr = idn_nul then
         d:= cons(ts, id_tipus_index); 
         if tsexpr /= d.dt.tsub then 	
            put("Error: Tipus subjacents diferents. "); 
            raise error_index; 
         end if;	
      else
         if texpr /= id_tipus_index then
            put("Error: Tipus subjacents diferents. "); 
            raise error_index;
         end if;		
      end if; 
      exception
         when error_index => 
            error:= true;
            new_line;
   end ct_index; 

   procedure ct_ref_comp(ref_comp: in ast; t: out id_nom; tsub: out tipus_sub;
                         it: out it_index; var, error: in out boolean) is
      texpr, tref: id_nom;
      tsexpr, tsref: tipus_sub; 
      v: valor;
      varexpr, varref: boolean := false;
      da, dc: descripcio; 
      error_ref_comp: exception;
   begin	
      if ref_comp.rc_llista_ref.tnd = n_ref_comp then
         ct_ref_comp(ref_comp.rc_llista_ref, t, tsub, it, var, error); 
         it:= seg_index(ts, it);					
      else
         ct_ref(ref_comp.rc_llista_ref, tref, tsref, varref, error); 
         if tsref /= tsarray then
            put("Error: No es un array. "); 
            raise error_ref_comp; 
         end if; 
         it:= primer_index(ts, tref); 
         t:= tref;  			
         tsub:= tsref;		
         var:= varref;		
      end if; 

      if not esvalid(it) then	
         put("Error: Sobren parametres"); 
         raise error_ref_comp;
      end if; 
      ct_exp(ref_comp.rc_expr, texpr, tsexpr, v, varexpr, error);
      ct_index(it, texpr, tsexpr, error);		
      
      exception
         when error_ref_comp => 
            error := true; 		
            new_line;
   end ct_ref_comp;

   procedure ct_ref(ref: in ast; t: out id_nom; tsub: out tipus_sub;
                    var, error: in out boolean) is
      id: id_nom;
      dt, dc: descripcio;
      it: it_index;
      error_ref: exception; 
   begin
      if ref.tnd = n_identif then
         ct_identif(ref, t, tsub, var, error); 
      elsif ref.tnd = n_ref_comp then
         --Referencia composta
         ct_ref_comp(ref, t, tsub, it, var, error);
         it:= seg_index(ts, it); 
         if esvalid(it) then	
            put("Error: Falten parametres.");
            raise error_ref; 
         end if; 		
         dt:= cons(ts, t); 
         dc:= cons(ts, dt.dt.tcomp);
         t:= dt.dt.tcomp; 
         tsub:= dc.dt.tsub;
      else  
         --ref.id
         ct_ref(ref.r_llista_ref, t, tsub, var, error); 
         id:= ref.r_identif.id;
         if tsub /= tsrec then
            put("Error: Tipus subjacent incorrecte."); 
            raise error_ref; 
         end if;
         dc:= cons_camp(ts, t, id);
         if dc.td = d_nul then
            put("Error: No es un camp del record."); 
            raise error_ref;
         end if; 
         dt:= cons(ts, dc.tc);
         t:= dc.tc;				
         tsub:= dt.dt.tsub;	 			
      end if;	

      exception
         when error_ref => 
            error := true; 
            new_line;
   end ct_ref; 

   procedure ct_exp(exp: in ast; t: out id_nom; tsub: out tipus_sub;
                    v: out valor; var, error: in out boolean) is
      t1, t2: id_nom;		
      tsub_camp1, tsub_camp2: tipus_sub;
      it: it_index;
      dt, dc: descripcio;
      error_exp: exception;
   begin
      case exp.tnd is
         when n_lit_enter => 
            t:= idn_nul;
            tsub:= tsenter; 
            v:= exp.vl;		
            var:= false;		
         when n_lit_caracter => 
            t:= idn_nul;
            tsub:= tscar; 
            v:= exp.caracter;
            var:= false;
         when n_lit_string => 
            t:= idn_nul;
            tsub:= tsstr; 
            v:= valor(exp.cadena);		
            var:= false; 
         when n_identif => 
            ct_identif(exp, t, tsub, var, error); 
         when n_ref =>   
            ct_ref(exp, t, tsub, var, error);		
         when n_ref_comp => 
            ct_ref_comp(exp, t, tsub, it, var, error); 	
            it:= seg_index(ts, it); 
            if esvalid(it) then	
               put("Error: Falten parametres. "); 
               raise error_exp; 
            end if; 	
            dt:= cons(ts, t); 
            dc:= cons(ts, dt.dt.tcomp);
            t:= dt.dt.tcomp; 
            tsub:= dc.dt.tsub;
         when n_expr => 
            if exp.e_camp1 /= null then
               ct_exp(exp.e_camp1, t1, tsub_camp1, v, var, error);
            end if;
            if exp.e_camp2 /= null then	
               ct_exp(exp.e_camp2, t2, tsub_camp2, v, var, error);				
            end if;
            case exp.e_operacio is
               when o_mes | o_menys | o_producte | 
                     o_divisio | o_modul =>
                  if tsub_camp1 /= tsenter then
                     put("Error: Tipus incorrecte. "); 
                     raise error_exp;
                  end if;
                  if tsub_camp2 /= tsenter then
                     put("Error: Tipus incorrecte. "); 
                     raise error_exp;
                  end if;
                  tsub:= tsenter;
                  if t1 = idn_nul then
                     t:= t2;
                  elsif t2 = idn_nul then
                     t:= t1;
                  elsif t1 /= t2 then
                     put("Error: Els components de l'expresio son de diferent tipus. ");
                     raise error_exp; 
                  else 
                     t:= t1;
                  end if; 
                  var:= false; 			
               when o_and | o_or => 
                  if t1 /= t2 then
                     put("Error: Els components de l'expresio son de diferent tipus. ");
                     raise error_exp;
                  end if;
                  if tsub_camp1 /= tsbool then
                     put("Error: L'expresio no es booleana. "); 
                     raise error_exp;
                  end if;
                  t:= t1;
                  tsub:= tsbool;						 
                  var:= false; 			
               when o_igual | o_diferent | o_menor |
                     o_major | o_menor_igual | o_major_igual => 
                  if tsub_camp1 /= tsub_camp2 then
                     put("Error: Els components de l'expresio son de diferent tipus. ");
                     raise error_exp;
                  end if;
                  if t1 /= idn_nul or t2 /= idn_nul then
                     if t1 /= t2 then
                        put("Error: Els components de l'expresio son de diferent tipus. ");
                        raise error_exp;
                     end if;
                  end if; 					
                  if tsub_camp1 > tsenter then 
                     put("Error: El tipus a comparar no es un escalar. "); 
                     raise error_exp;
                  end if; 
                  t:= id_bool; 							
                  tsub:= tsbool; 
                  var:= false; 
               when o_menys_unitari => 
                  if tsub_camp1 /= tsenter then
                     put("Error: Menys incompatible amb el tipus. "); 
                     raise error_exp;
                  end if;
                  t:= t1;
                  tsub:= tsub_camp1;
                  var:= false;					
               when o_not => 
                  if tsub_camp1 /= tsbool then
                     put("Error: Not incompatible amb el tipus. "); 
                     raise error_exp;
                  end if;
                  t:= t1;
                  tsub:= tsub_camp1;
                  var:= false;
               when others => null;
            end case;			
         when others => null;
      end case;

      exception
         when error_exp =>
            error := true; 
            new_line;
   end ct_exp; 

   procedure ct_sent_buc(buc: in ast; error: in out boolean) is
      t: id_nom;		
      tsubexp: tipus_sub;
      v: valor;
      var: boolean := false; 
      error_sent_buc: exception; 	
   begin
      ct_exp(buc.sb_condicio, t, tsubexp, v, var, error); 
      if tsubexp /= tsbool then
         put("Error: La condicio del bucle no es un boolea. ");
         raise error_sent_buc; 
      end if;
      ct_sents(buc.sb_sents, error);			
      exception
         when error_sent_buc => 
            error := true;	
            new_line;
   end ct_sent_buc; 

   procedure ct_sent_fluxe(fluxe: in ast; error: in out boolean) is
      t: id_nom;		
      tsubexp: tipus_sub;
      v: valor;
      var: boolean := false;  
      error_sent_fluxe: exception;
   begin
      ct_exp(fluxe.sf_condicio, t, tsubexp, v, var, error);
      if tsubexp /= tsbool then
         put("Error: La condicio del if no es un boolea. ");
         raise error_sent_fluxe; 
      end if;
      ct_sents(fluxe.sf_sents, error);	
      if fluxe.sf_sents_else /= null then
         ct_sents(fluxe.sf_sents_else, error); 
      end if;		
      exception
         when error_sent_fluxe => 
            error := true;	
            new_line;
   end ct_sent_fluxe;

   procedure ct_sent_assig(assig: in ast; error: in out boolean) is 
      t1, t2: id_nom;		
      tsub1, tsub2: tipus_sub;
      v: valor;	
      var1, var2: boolean := false;
      error_sent_assig: exception;
   begin
      ct_ref(assig.sa_ref, t1, tsub1, var1, error); 
      ct_exp(assig.sa_expr, t2, tsub2, v, var2, error);
      if var1 then
         if t2 = idn_nul then
            if tsub1 /= tsub2 then
               put("Error: Tipus de les assignacions diferent. "); 
               raise error_sent_assig;
            end if; 
         else 
            if t1 /= t2 then
               put("Error: Tipus de les assignacions diferent. "); 
               raise error_sent_assig;
            end if;  
         end if;
      else 
         put("Error: Component esquerra de l'assignacio incorrecte. "); 
         raise error_sent_assig;
      end if;

      exception
         when error_sent_assig => 
            error:= true;
            new_line; 
   end ct_sent_assig; 

   procedure ct_param(it: it_param; texpr: in id_nom; tsexpr: in tipus_sub;
                      var, error: in out boolean) is
      id_param, id_tipus_param: id_nom;		
      d, dp: descripcio; 
      error_param: exception;
   begin 
      cons_param(ts, it, id_param, dp);
      id_tipus_param:= dp.tp;		
      if dp.mode = m_out and not var then
         put("Error: No es pot asignar valor al parametre '");
         put(con_id(tn, id_param)); put("' perque es de sortida. ");
         raise error_param;
      end if;	
      if texpr = idn_nul then
         d:= cons(ts, id_tipus_param); 
         if tsexpr /= d.dt.tsub then 	
            put("Error: El parametre '"); put(con_id(tn, id_param));
            put("' no es del tipus correcte. "); 
            raise error_param;
         end if;	
      else
         if texpr /= id_tipus_param then
            put("Error: El parametre '"); put(con_id(tn, id_param));
            put("' no es del tipus correcte. ");
            raise error_param;
         end if;		
      end if; 

      exception
         when error_param => 
            error:= true;
            new_line;
   end ct_param; 
               
   procedure ct_params_proc(params: in ast; t: out id_nom; tsub: out tipus_sub;
                            it: out it_param; var, error: in out boolean) is
      texpr: id_nom;
      tsexpr: tipus_sub; 
      v: valor;
      varexpr: boolean := false;
      dt: descripcio; 
      error_params_proc : exception;
   begin	
      if params.rc_llista_ref.tnd = n_ref_comp then
         ct_params_proc(params.rc_llista_ref, t, tsub, it, var, error); 
         it:= seg_param(ts, it);					
      else
         dt:= cons(ts, params.rc_llista_ref.id);
         if dt.td /= d_proc then
            put("Error: L'identificador '");
            put(con_id(tn, params.rc_llista_ref.id));
            put("' no es un procediment. ");
            raise error_params_proc;  
         end if; 		
         it:= primer_param(ts, params.rc_llista_ref.id); 
         t:= params.rc_llista_ref.id;  			
         tsub:= tsnul;		
         var:= false;		
      end if; 

      if not esvalid(it) then	
         put("Error: Sobren parametres al procediment."); 
         raise error_params_proc;
      end if; 
      ct_exp(params.rc_expr, texpr, tsexpr, v, varexpr, error);
      ct_param(it, texpr, tsexpr, varexpr, error); 
      
      exception
         when error_params_proc => 
            error:= true; 	
            new_line;	
   end ct_params_proc;

   procedure ct_sent_proc(sent: in ast; error: in out boolean) is
      t: id_nom; 
      tsub: tipus_sub; 
      dt: descripcio;
      it: it_param; 	
      var: boolean := false;
      error_sent_proc: exception;
   begin
      if sent.tnd = n_ref_comp then
         ct_params_proc(sent, t, tsub, it, var, error); 
         it:= seg_param(ts, it); 
         if esvalid(it) then	         
				put("Error: Falten parametres al procediment '");
            put(con_id(tn, t)); put("'. "); 
            raise error_sent_proc;
         end if; 		
      else 
         dt:= cons(ts, sent.id);
         if dt.td /= d_proc then
			   put("Error: El procediment '"); put(con_id(tn, sent.id));
            put("' no esta declarat. "); 
            raise error_sent_proc;
         end if; 
         it:= primer_param(ts, sent.id);
         if esvalid(it) then
				put("Error: Falten parametres al procediment '");
            put(con_id(tn, sent.id)); put("'. "); 
            raise error_sent_proc;
         end if;
      end if;

      exception
         when error_sent_proc =>
            error:= true;
            new_line;			
   end ct_sent_proc; 

   procedure ct_sents(sents: in ast; error: in out boolean) is
      sent: ast;
   begin
      if sents.tnd = n_sents then 
         ct_sents(sents.s_sents, error);
         sent:= sents.s_sent;
      else 
         sent:= sents; 
      end if; 
      
      case sent.tnd is
         when n_sent_buc => ct_sent_buc(sent, error);   
         when n_sent_flux => ct_sent_fluxe(sent, error);  
         when n_sent_assig => ct_sent_assig(sent, error);
         when others => ct_sent_proc(sent, error);  
      end case; 
   end ct_sents;

   procedure ct_dec_proc(proc: in ast; error: in out boolean) is
      id_inici, id_fi, id_param: id_nom;
      d_param: descripcio;
      it: it_param;
      e: boolean;
   begin   
		md_dec_proc(inici);
      id_inici:= proc.dp_identif_inici.id;
      id_fi:= proc.dp_identif_fi.id;
      if id_inici /= id_fi then
			put("Error: Nom del procediment '"); put(con_id(tn, id_inici));
         put("' diferent. "); 
         new_line;
         error:= true;      
      end if;
      np:= np + 1;      
      posa(ts, id_inici, (d_proc, np), e);
      if e then
			--me_proc_existent();
         error:= true;
      end if;
      if proc.dp_encap /= null then
         ct_dec_params(proc.dp_encap.e_params, id_inici, error);
         entrabloc(ts);
         it:= primer_param(ts, id_inici);
         while esvalid(it) loop 
            cons_param(ts, it, id_param, d_param);
            nv:= nv + 1;
            d_param.n_param:= nv;
            posa(ts, id_param, d_param, e);
            it:= seg_param(ts, it);
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
		md_dec_proc(fi);
   end ct_dec_proc;
      
   procedure comprova_tipus is
      error: boolean := False;
   begin
		md_main;
      ct_dec_proc(arrel, error);
      if error then
         raise Error_semantic;
      end if;
   end comprova_tipus;

   end semantica.comprovacio_tipus;
