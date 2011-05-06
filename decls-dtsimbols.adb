with ada.text_io; use ada.text_io;
package body decls.dtsimbols is

   procedure tbuida(ts: out tsimbols) is
      prof: index_tambit renames ts.prof;
      ta: tambits renames ts.ta;
      td: tdescripcions renames ts.td;
      d : descripcio(d_nul);
   begin
      prof := 1;
      ta(prof) := 0;
      for id in id_nom loop
         td(id) := (0, d, idn_nul);
      end loop;
   end tbuida;

   procedure posa(ts: in out tsimbols; id: in id_nom; d: in descripcio;
      error: out boolean) is
      ne : id_nom;
      td: tdescripcions renames ts.td;
      ta: tambits renames ts.ta;
      te: texpansio renames ts.te;
      prof: index_tambit renames ts.prof;
   begin
      error := td(id).profd = prof;
      if not error then
         ta(prof) := ta(prof) + 1;
         ne := ta(prof);
         te(ne) := (td(id).profd, td(id).d, id, td(id).s);
         td(id) := (prof, d, idn_nul);
      end if;
   end posa;

   function cons(ts: in tsimbols; id: in id_nom) return descripcio is
      td: tdescripcions renames ts.td;
   begin
      return td(id).d;
   end cons;

   procedure entrabloc(ts: in out tsimbols) is
      prof: index_tambit renames ts.prof;
      ta: tambits renames ts.ta;
   begin
      prof := prof + 1;
      ta(prof) := ta(prof - 1);
   end entrabloc;


   procedure surtbloc(ts: in out tsimbols) is
      ne : id_nom;
      id : id_nom;
      td: tdescripcions renames ts.td;
      ta: tambits renames ts.ta;
      te: texpansio renames ts.te;
      prof: index_tambit renames ts.prof;
   begin
      ne := ta(prof);
      prof := prof - 1;
      while ne > ta(prof) loop
         if te(ne).profd >= 0 then
            id := te(ne).ptd;
            td(id) := (te(ne).profd, te(ne).d, te(id).s);
         end if;
         ne := ne - 1;
      end loop;
   end surtbloc;

   procedure posa_camp(ts: in out tsimbols; idr, idc: in id_nom;
                      d: in descripcio; error: out boolean) is
      dr: descripcio;
      ie, ne: id_nom;
      td: tdescripcions renames ts.td;
      ta: tambits renames ts.ta;
      te: texpansio renames ts.te;
      prof: index_tambit renames ts.prof;
   begin
      dr := td(idr).d;
      if not (dr.td = d_tipus and then dr.dt.tsub = tsrec) then
         raise mal_us;
      end if;
      ie := td(idr).s;
      while ie /= 0 and then te(ie).ptd /= idc loop
         ie := te(ie).s;
      end loop;
      error := (ie /= 0);
      if not error then
         ta(prof) := ta(prof) + 1;
         ne := ta(prof);
         te(ne) := (-1, d, idc, td(idr).s);
         td(idr).s := ne;
      end if;
   end posa_camp;

   function cons_camp(ts: in tsimbols; idr, idc: in id_nom)
                     return descripcio is
      d: descripcio(d_nul);
      dr, dc: descripcio;
      ie: id_nom;
      td: tdescripcions renames ts.td;
      te: texpansio renames ts.te;
   begin
      dr := td(idr).d;
      if not (dr.td = d_tipus and then dr.dt.tsub = tsrec) then
         raise mal_us;
      end if;
      ie := td(idr).s;
      while ie /= 0 and then te(ie).ptd /= idc loop
         ie := te(ie).s;
      end loop;
      if ie = 0 then
         dc := d;
      else       
         dc := te(ie).d;
      end if;
      return dc;
   end cons_camp;

   procedure actualitza(ts: in out tsimbols; id: in id_nom; d: in descripcio) is
      td : tdescripcions renames ts.td;
   begin
      td(id).d := d;
   end actualitza;

   procedure posa_index(ts: in out tsimbols; ida: in id_nom; di: in id_nom) is
      da : descripcio;
      d: descripcio(d_nul);
      ie, pie, ne : id_nom;
      td: tdescripcions renames ts.td;
      ta: tambits renames ts.ta;
      te: texpansio renames ts.te;
      prof: index_tambit renames ts.prof;
   begin
      da := td(ida).d;
      if not (da.td = d_tipus and then da.dt.tsub = tsarray) then
         raise mal_us;
      end if;
      ie := td(ida).s; pie := 0;
      while ie /= 0 loop
         pie := ie;
         ie := te(ie).s;
      end loop;
      ta(prof) := ta(prof) + 1;
      ne := ta(prof);
      te(ne).ptd := di;
      te(ne).profd := -1;
      te(ne).d := d;
      if pie = 0 then
         td(ida).s := ne;
         te(ne).s := 0;
      else
         te(pie).s := ne;
         te(ne).s := 0;
      end if;
   end posa_index;

   function primer_index(ts: in tsimbols; ida: in id_nom) return it_index is
      da: descripcio;
      td: tdescripcions renames ts.td;
   begin
      da := td(ida).d;
      if not (da.td = d_tipus and then da.dt.tsub = tsarray) then
         raise mal_us;
      end if;
      return it_index(td(ida).s);
   end primer_index;

   function seg_index(ts: in tsimbols; it: in it_index) return it_index is
      te: texpansio renames ts.te;
   begin
      return it_index(te(id_nom(it)).s);
   end seg_index;

   function esvalid(it: in it_index) return boolean is
   begin
      return it /= 0;
   end esvalid;

   function cons_index(ts: in tsimbols; it: in it_index) return id_nom is
      te: texpansio renames ts.te;
   begin
      return te(id_nom(it)).ptd;
   end cons_index;

   procedure posa_param(ts: in out tsimbols; idproc, idparf: in id_nom;
                        dparf: in descripcio; dperf: out boolean) is
      dproc : descripcio;
      ie, pie, ne : id_nom;
      td: tdescripcions renames ts.td;
      te: texpansio renames ts.te;
      ta: tambits renames ts.ta;
      prof: index_tambit renames ts.prof;
   begin
      dproc := td(idproc).d;
      if (dproc.td /= d_proc) then
         raise mal_us;
      end if;
      ie := td(idproc).s; pie := 0;
      while ie /= 0 and then te(ie).ptd /= idparf loop
         pie := ie;
         ie := te(ie).s;
      end loop;
      dperf := (ie/=0);
      if not dperf then
         ta(prof) := ta(prof) + 1;
         ne := ta(prof);
         te(ne).ptd := idparf;
         te(ne).profd := -1;
         te(ne).d := dparf;
         if pie = 0 then
            td(idproc).s := ne;
            te(ne).s := 0;
         else
            te(pie).s := ne;
            te(ne).s := 0;
         end if;
      end if;
   end posa_param;

   function primer_param(ts: in tsimbols; idproc: in id_nom)
            return it_param is
         d : descripcio;
         td: tdescripcions renames ts.td;
   begin
      d := td(idproc).d;
      if d.td /= d_proc then
         raise mal_us;
      end if;
      return it_param(td(idproc).s);
   end primer_param;

   function seg_param(ts: in tsimbols; it: in it_param) return it_param is
      te: texpansio renames ts.te;
   begin
      return it_param(te(id_nom(it)).s);
   end seg_param;

   function esvalid(it: in it_param) return boolean is
      begin
         return it /= 0;
   end esvalid;

   procedure cons_param(ts: in tsimbols; it: in it_param;
      idparf: out id_nom; dparf: out descripcio) is
      te: texpansio renames ts.te;
   begin
      idparf := te(id_nom(it)).ptd;
      dparf := te(id_nom(it)).d;
   end cons_param;
end decls.dtsimbols;
