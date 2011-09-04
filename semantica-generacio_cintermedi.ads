with decls.c3a, decls.dpila, ada.text_io, ada.direct_io;
use decls.c3a;

package semantica.generacio_cintermedi is

   procedure genera_cintermedi(nom: in string);

	package c3a_bin is new ada.direct_io(ic3a);
   use c3a_bin;

	type param is record
		res, desp: num_var;
   end record;

   package pila_par is new decls.dpila(param);
   use pila_par;

private

	fbin_c3a: c3a_bin.file_type;
	ftxt_c3a: ada.text_io.file_type;
	prof: num_prof := num_prof'first;
	pila_proc: v_prof;
	pila_param: pila;
	const_fals, const_cert: num_var;

end semantica.generacio_cintermedi;
