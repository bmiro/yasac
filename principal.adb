with lexic_io; use lexic_io;
with analitzador_sintactic; use analitzador_sintactic;
with semantica; use semantica;

procedure principal is
begin

    Open_Input("codi.ysa");
    inicia_analitzador;
    yyparse;
    Close_Input;

end principal;
