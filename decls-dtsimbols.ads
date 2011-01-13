with decls.generals; use decls.generals;
with decls.descripcions; use decls.descripcions;
package decls.dtsimbols is

   type tsimbols is limited private;
   type it_index is private;
   type it_param is private;
   mal_us: exception;

   procedure tbuida(ts: out tsimbols);
   procedure posa(ts: in out tsimbols; id: in id_nom; d: in descripcio;
		  error: out boolean);
   function cons(ts: in tsimbols; id: in id_nom) return descripcio;
   procedure entrabloc(ts: in out tsimbols);
   procedure surtbloc(ts: in out tsimbols);

   procedure posa_camp(ts: in out tsimbols; idr, idc: in id_nom;
		       d: in descripcio; error: out boolean);
   function cons_camp(ts: in tsimbols; idr, idc: in id_nom) return descripcio;

   procedure actualitza(ts: in out tsimbols; id: in id_nom; d: in descripcio);

   procedure posa_index(ts: in out tsimbols; ida: in id_nom; di: in id_nom);
   function primer_index(ts: in tsimbols; ida: in id_nom) return it_index;
   function seg_index(ts: in tsimbols; it: in it_index) return it_index;
   function esvalid(it: in it_index) return boolean;
   function cons_index(ts: in tsimbols; it: in it_index) return id_nom;

   procedure posa_param(ts: in out tsimbols; idproc, idparf: in id_nom;
			dparf: in descripcio; dperf: out boolean);
   function primer_param(ts: in tsimbols; idproc: in id_nom) return it_param;
   function seg_param(ts: in tsimbols; it: in it_param) return it_param;
   function esvalid(it: in it_param) return boolean;
   procedure cons_param(ts: in tsimbols; it: in it_param; idparf: out id_nom;
			dparf: out descripcio);

private

   subtype index_tdesp is id_nom;
   subtype index_texp is id_nom;
   type index_tambit is new integer range -1..maxid;
   type it_index is new natural range 0..maxid;
   type it_param is new natural range 0..maxid;

   type bloc_desc is
      record
	 profd: index_tambit;
	 d: descripcio;
	 s: index_texp;
      end record;

   type bloc_exp is
      record
	 profd: index_tambit;
	 d: descripcio;
	 ptd: id_nom;
	 s: index_texp;
      end record;

   type tdescripcions is array(index_tdesp) of bloc_desc;
   type texpansio is array(index_texp) of bloc_exp;
   type tambits is array(index_tambit) of id_nom;

   type tsimbols is
      record
	 td: tdescripcions;
	 te: texpansio;
	 ta: tambits;
	 prof: index_tambit;
      end record;

end decls.dtsimbols;
