with decls.c3a, decls.generals, ada.text_io, ada.direct_io;
use decls.c3a, decls.generals, ada.text_io;
package semantica.generacio_cassemblador is

   package c3a_bin is new ada.direct_io(ic3a);
   use c3a_bin;

   procedure genera_cassemblador(nom: in string);

private
   fbin_c3a: c3a_bin.file_type;
   asm: ada.text_io.file_type; --mirar de canviar nom ftxt_asam
   prof_actual : num_prof := 1;

end semantica.generacio_cassemblador;
