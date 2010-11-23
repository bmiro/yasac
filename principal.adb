with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
with decls.datribut; use decls.datribut;
with lexic_io; use lexic_io;
with a_lexic; use a_lexic;

procedure principal is	
    x: token;
begin

    Open_Input("codi.ysa");
    inicialitzacio;
    
    loop
      x := yylex;
      put(token'image(x)); new_line;
      exit when x = End_Of_Input;
    end loop;	

end principal;
