package body decls.dtnoms is

   procedure tbuida(tn: out Tnoms) is
      tdispersio : taula_dispersio renames tn.tdispersio;
      idx_tblocs : id_nom renames tn.idx_tblocs;
      idx_tcaracters : index_tcaracters renames tn.idx_tcaracters;
   begin
      for i in 0..tam_tdispersio loop
         tdispersio(i) := id_nom'first;   --id_nom'first indica que no apunta enlloc
      end loop;
      idx_tblocs := id_nom'first+1;
      idx_tcaracters := index_tcaracters'first;
   end tbuida;
   
  -- Esmicolament Quadratic basat en: 
  -- A Premier on program Constuction: IV. Data Structrures, Draft 1.1
  -- Març 2010, Albert Llemosí.
  -- Chapter 4, Section 10, subsection 6, paragraph Quadratic hashing.
   function hash (s: in String) return natural is
      n: constant natural := s'last;
      m: constant natural := character'pos(character'last)+1;
      c: natural;
      k, l: integer;
      a: array (1..n) of natural;
      r: array(1..2*n) of natural;
   begin
      for i in s'range loop a(i) := character'pos(s(i)); end loop;
      for i in 1..2*n loop r(i) := 0; end loop;
      k := 2*n+1;
      for i in reverse 1..n loop
         k := k-1; l := k; c := 0;
         for j in reverse 1..n loop
            c := c + r(l) + a(i)*a(j);
            r(l) := c mod m; c := c/m;
            l := l-1;
         end loop;
         r(l) := c;
      end loop;
      c := (r(n)*m + r(n+1)) mod tam_tdispersio;
      return c;
   end hash;

   --Insereix un string dins la taula de caracters
   procedure posa(tc: in out taula_caracters; idx_tc: in out index_tcaracters;
		  s: in string) is
   begin
      for i in s'first..s'last loop
         tc(idx_tc) := s(i);
         idx_tc := index_tcaracters'succ(idx_tc);
      end loop;
      tc(idx_tc) := Ascii.NUL;
      idx_tc := index_tcaracters'succ(idx_tc);
   end posa;

   --Compara un string amb un altre ja introduit dins la taula de caracters
   --si son iguals retorna true, sino false
	function compara(tc: in taula_caracters; s: in string;
                    id: in index_tcaracters) return boolean is
		idx_tcaracters : index_tcaracters := id;
		idx_s : natural := s'first;
	begin
      while tc(idx_tcaracters) = s(idx_s) and idx_s < s'last loop
         idx_tcaracters := index_tcaracters'succ(idx_tcaracters);
         idx_s := natural'succ(idx_s);
      end loop;
      return (tc(idx_tcaracters) = s(idx_s) and
              idx_s = s'last and
              tc(idx_tcaracters + 1) = Ascii.NUL);
   end compara;

   procedure posa_id(tn: in out Tnoms; s: in string; id: out id_nom) is
      p : natural;
      idx : id_nom;
      tdispersio: taula_dispersio renames tn.tdispersio;
      tblocs : taula_blocs renames tn.tblocs;
      tcaracters : taula_caracters renames tn.tcaracters;
      idx_tblocs : id_nom renames tn.idx_tblocs;
      idx_tcaracters : index_tcaracters renames tn.idx_tcaracters;
   begin
      p := hash(s);
      idx := tdispersio(p);
      while idx /= id_nom'first and then
        not compara(tcaracters, s, tblocs(idx).ptcaracters) loop
         idx := tblocs(idx).ptblocs;
      end loop;
      if idx = id_nom'first then
         id := idx_tblocs;
         tblocs(idx_tblocs).ptcaracters := idx_tcaracters;
         posa(tcaracters, idx_tcaracters, s);
         idx_tblocs := idx_tblocs + 1;
      end if;
   end posa_id;

   procedure posa_cad(tn: in out Tnoms; s: in string; id: out id_string) is
      tcaracters : taula_caracters renames tn.tcaracters;
      idx_tcaracters : index_tcaracters renames tn.idx_tcaracters;
   begin
      id := idx_tcaracters;
      posa(tcaracters, idx_tcaracters, s);
   end posa_cad;

   --retorna la posicio on acaba l'string a llegir
   function con(tc: in taula_caracters; idx: in index_tcaracters)
		return index_tcaracters is
      i : index_tcaracters;
   begin
      i := idx;
      while tc(i) /= Ascii.NUL loop
         i := index_tcaracters'succ(i);
      end loop;
      return i;
   end con;

   function con_id(tn: in Tnoms; id: in id_nom) return string is
      i : index_tcaracters;
      tblocs : taula_blocs renames tn.tblocs;
      tc : taula_caracters renames tn.tcaracters;
   begin
      i := con(tc, tblocs(id).ptcaracters);
      return string(tc(tblocs(id).ptcaracters..i));
   end con_id;

   function con_cad(tn: in Tnoms; id: in id_string) return string is
      i : index_tcaracters;
      tc: taula_caracters renames tn.tcaracters;
   begin
      i := con(tc, id);
      return string(tc(id..i));
   end con_cad;

end decls.dtnoms;
