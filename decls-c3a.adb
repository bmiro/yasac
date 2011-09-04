with ada.text_io, ada.integer_text_io, ada.strings,
  ada.strings.fixed, ada.strings.maps;

use ada.text_io, ada.integer_text_io, ada.strings,
  ada.strings.fixed, ada.strings.maps;

package body decls.c3a is

  procedure posa_var(tv: in out tvariables; nv: in num_var;
                                                 var: in variable) is
   begin
      tv(nv):= var;
   end posa_var;

   function cons_var(tv: in tvariables; nv: in num_var) return variable is
   begin
      return tv(nv);
   end cons_var;

   procedure posa_proc(tp: in out tprocediments;
                       np: in num_proc; proc: in procediment) is
   begin
      tp(np):= proc;
   end posa_proc;

   function cons_proc(tp: in tprocediments;
                      np: in num_proc) return procediment is
   begin
      return tp(np);
   end cons_proc;

   function nova_etq return num_etq is
   begin
      etq:= etq + 1;
      return etq;
   end nova_etq;

   procedure put_v(f: in file_type; var_l: in variable) is
     use tipus_var_enum;
     use tipus_sub_enum;
   begin
     put(f, var_l.t_var);
     put(f, " | ");
     case var_l.t_var is
       when t_null => null;
       when var | par => -- trim(num_var'image(i), both)
         put(f, "proc: "); put(f, num_proc'image(var_l.proc));  put(f, " | ");
         put(f, "ocup: "); put(f, natural'image(var_l.ocup)); put(f, " | ");
         put(f, "despl: "); put(f, integer'image(var_l.despl)); put(f, " | ");
         put(f, "id: "); put(f, id_nom'image(var_l.id));
       when const =>
         put(f, "val: "); put(f, valor'image(var_l.val)); put(f, " | ");
         put(f, "tsub: "); put(f, tipus_sub'image(var_l.tsub));
     end case;
   end put_v;

   procedure put(file: in out file_type; var_l: in variable) is
     use tipus_var_enum;
     use tipus_sub_enum;
   begin
     put(file, var_l.t_var);
     put(file, "  ");
     case var_l.t_var is
       when t_null => null;
       when var | par =>
         put(file, integer(var_l.proc));
         put(file, var_l.ocup);
         put(file, var_l.despl);
         put(file, integer(var_l.id));
       when const =>
         put(file, integer(var_l.val));
         put(file, var_l.tsub);
     end case;
     new_line(file);
   end put;

   procedure put_tv(tv: in tvariables; f: in file_type) is
      null_counter : integer := 0;
   begin
      put_line(f, "taula de variables");
      put_line(f, "variable n;     var, constant, variable_nulla");
     for i in tv'range loop
       put(f, trim(num_var'image(i), both));
       put(f, "  ");
       put_v(f, tv(i));
       new_line(f);
       if tv(i).t_var = t_null then
         null_counter := null_counter +1;
         if null_counter > 3 then
           exit;
         end if;
       end if;
     end loop;
   end put_tv;

   procedure put_p(f: in file_type; proc: in procediment) is
   begin
     case proc.t_proc is
       when intern =>
            put(f, "intern  ");
        when extern =>
          put(f, "extern  ");
       when others =>
         put(f, "nul");
         return;
      end case;
      put(f, natural(proc.n_params));
      put(f, Integer(proc.Idproc));
      case proc.t_proc is
         when intern =>
            put(f, integer(proc.prof));
            put(f, Natural(Proc.ocup));
        when extern =>
          put(f, integer(proc.idetq));
         when others =>
            null;
      end case;
   end put_p;

   procedure put_tp(tp: in tprocediments; f: in file_type) is
     null_counter : integer := 0;
   begin
     put_line(f, "taula de procediments");
     put_line(f, "n; secció;    n params;       id; prof/idet;   ocupacio");
     for i in tp'range loop
       put(f, trim(num_proc'image(i), both));
       put(f, "  ");
       put_p(f, tp(i));
       new_line(f);
       if tp(i).t_proc = t_null then
         null_counter := null_counter +1;
         if null_counter > 2 then
           exit;
         end if;
       end if;
     end loop;
   end put_tp;

end decls.c3a;

