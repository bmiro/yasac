with ada.strings, ada.strings.fixed, ada.strings.maps;
use ada.strings, ada.strings.fixed, ada.strings.maps;
package body semantica.generacio_cassemblador is

   procedure prepara_asm (nom: in string) is
   begin
      open(fbin_c3a, in_file, nom & ".c3ab");
      create(asm, append_file,  nom & ".s");
   end prepara_asm;

   procedure finalitza_asm is
   begin
      close(fbin_c3a);
      close(asm);
   end finalitza_asm;

   procedure llegeix_inst(inst: out ic3a) is
   begin
      read(fbin_c3a, inst);
   end llegeix_inst;

   procedure genera_cassemblador(nom: in string) is
      inst: ic3a;
   begin
      prepara_asm(nom);
      --genera_cap;
      while not c3a_bin.end_of_file(fbin_c3a) loop
         llegeix_inst(inst);
         case inst.codi is
            when copia =>  put("Copia"); new_line;           
            when cons_idx | copia_idx => put("Copia | Cons idx"); new_line;           
            when suma | resta |
                 mult | and_logic |
                 or_logic => put("Suma, resta, mult, and, or"); new_line;                                                    
            when call | preamb |rtn | params |
                 paramc => put("call, preamb, rtn, params, paramc"); new_line;
            when goto_op => put("goto_op"); new_line;                                
            when etiq => put("etiq"); new_line;              
            when op_igual |
                 op_desigual |
                 op_menor |
                 op_major |
                 op_menorig |
                 op_majorig => put("igual, desigual, menor, major, menorig, majorig"); new_line;        
          when resta_unitaria |
                 not_logic => put("resta unitaria, not logic"); new_line;          
			 when div => put("div"); new_line;                           
			 when modul => put("modul"); new_line;                         
            when others => null;
         end case;
      end loop;
      finalitza_asm;
   end genera_cassemblador;

end semantica.generacio_cassemblador;
