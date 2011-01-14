with decls; use decls;
package decls.generals is

   maxid: constant natural := 1001;
   maxstr: constant natural := 1000;
   long_mitja_id: constant natural := 10;
   long_mitja_str: constant natural := 20;
   tam_tcaracters: constant natural := maxid *(long_mitja_id + 1) +
                                       maxstr*(long_mitja_str + 1);
   tam_tdispersio: constant natural := maxid;

   type id_nom is new natural range 0..maxid;
   subtype id_string is natural range 1..tam_tcaracters;
   type valor is new integer;

   type t_operacio is (o_mes, o_menys, o_producte, o_divisio, o_modul, o_menys_unitari,
		    o_and, o_or, o_not,
		    o_igual, o_diferent, o_menor, o_major, o_menor_igual, o_major_igual,
		    o_nul);
   type t_mode is (m_in, m_out, m_in_out);

end decls.generals;

