package body decls.dpila is

   procedure pbuida(p: out pila) is
   begin
	   p:= null;
   end pbuida;

   procedure empila(p: in out pila; e: in elem) is
      q: pbloc;
   begin
      q:= new bloc;    
		q.all.e:= e;
      q.all.s:= p;
      p:= q;
   exception
      when storage_error => raise desb_capacitat;
   end empila;

   procedure desempila(p: in out pila) is
   begin
      if p = null then
         raise mal_us;
      end if;
      p:= p.s;
   end desempila;

   function cim(p: in pila) return elem is
   begin
      if p = null then
         raise mal_us;
      end if;
      return p.all.e;
   end cim;

	function esbuida(p: in pila) return boolean is
   begin
      return p = null;
   end esbuida;

end decls.dpila;








