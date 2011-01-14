with lexic_io; use lexic_io;
with analitzador_sintactic; use analitzador_sintactic;
with decls.crea_arbre; use decls.crea_arbre;

procedure principal is
begin

    Open_Input("codi.ysa");
    inicia_tn;
    yyparse;
    Close_Input;

end principal;
