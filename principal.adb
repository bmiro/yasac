with lexic_io; use lexic_io;
with analitzador_sintactic; use analitzador_sintactic;
with semantica; use semantica;
with semantica.comprovacio_tipus; use semantica.comprovacio_tipus;
with semantica.generacio_cintermedi; use semantica.generacio_cintermedi;
with semantica.generacio_cassemblador; use semantica.generacio_cassemblador;
with semantica.missatges; use semantica.missatges;
procedure principal is
	codi: string := "codi.ysa";
begin

	Open_Input(codi);
   prepara_log(codi);
   inicia_analitzador;

   yyparse;
   comprova_tipus;
	genera_cintermedi(codi);
	genera_cassemblador(codi);

	finalitza_log;	
   Close_Input;

exception
   when Error_sintactic | Error_semantic => null;
end principal;
