generic
   type elem is private;

package decls.dpila is

	mal_us, desb_capacitat: exception;
   type pila is limited private;
   
	procedure pbuida(p: out pila);
   procedure empila(p: in out pila; e: in elem);
   procedure desempila(p: in out pila);
   function cim(p: in pila) return elem;
   function esbuida(p: in pila) return boolean;
   
	pragma inline(cim, esbuida);

private

   type bloc;
   type pila is access bloc;
   subtype pbloc is pila;

   type bloc is record
      e: elem;
      s: pbloc;
   end record;

end decls.dpila;
