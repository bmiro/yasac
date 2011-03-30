with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
with decls.dtnoms; use decls.dtnoms;
with decls.generals; use decls.generals;
procedure proves_tnoms is
	tn : Tnoms;
	id_n : id_nom;
	id_s : id_string;
begin
   tbuida(tn);
   posa_id(tn, "hola", id_n);
   put(con_id(tn, id_n)); new_line;
   put(id_n'img); new_line;
   posa_cad(tn, " hola ", id_s);
   put(con_cad(tn, id_s)); new_line;
   posa_id(tn, "hola", id_n);
   put(con_id(tn, id_n)); new_line;
   put(id_n'img); new_line;
   
   posa_id(tn, "compiladoasdadadadasdasdasd", id_n);
   put(con_id(tn, id_n)); new_line;
    
   posa_id(tn, "hola", id_n);
   put(con_id(tn, id_n)); new_line;
   put(id_n'img); new_line;
   
   posa_id(tn, "hola", id_n);
   put(con_id(tn, id_n)); new_line;
   put(id_n'img); new_line;
   
   posa_cad(tn, "Aixo es una cadena", id_s);
   put(con_cad(tn, id_s)); new_line;
      
   posa_id(tn, "ahol", id_n);
   put(con_id(tn, id_n)); new_line;
      
   posa_id(tn, "oalh", id_n);
   put(con_id(tn, id_n)); new_line;
    
   posa_cad(tn, "prova", id_s);
   put(con_cad(tn, id_s)); new_line;

   posa_id(tn, "hola", id_n);
   put(con_id(tn, id_n)); new_line;
end proves_tnoms;
