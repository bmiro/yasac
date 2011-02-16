with lexic_io; use lexic_io;
with analitzador_sintactic; use analitzador_sintactic;
with semantica; use semantica;
with semantica.comprovacio_tipus; use semantica.comprovacio_tipus;
procedure principal is
begin

	Open_Input("codi.ysa");
	inicia_analitzador;
	yyparse;
	comprova_tipus;	
	Close_Input;

exception
   when Error_sintactic | Error_semantic => null;

end principal;
