with decls.datribut; use decls.datribut;
with lexic_io; use lexic_io;
with analitzador_sintactic; use analitzador_sintactic;
procedure principal is	
begin

    Open_Input("codi2.ysa");
    inicialitzacio;
    yyparse;
    Close_Input;

end principal;
