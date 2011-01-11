%token Error
%token End_Of_Input
%token pc_and
%token pc_array
%token pc_begin
%token pc_constant
%token pc_else
%token pc_end
%token pc_for
%token pc_if
%token pc_in
%token pc_is
%token pc_loop
%token pc_mod
%token pc_new
%token pc_of
%token pc_or
%token pc_out
%token pc_procedure
%token pc_range
%token pc_record
%token pc_then
%token pc_type
%token pc_while
%token s_mes
%token s_menys
%token s_producte
%token s_divisio
%token s_igual
%token s_dos_punts
%token s_punt
%token s_puntpunt
%token s_coma
%token s_punt_i_coma
%token s_major
%token s_menor
%token s_major_igual
%token s_menor_igual
%token s_distint
%token s_assignacio
%token s_parentesi_obert
%token s_parentesi_tancat
%token literal
%token identificador
		
%left pc_or
%left pc_and

%nonassoc s_igual
		  s_menor
		  s_major
		  s_menor_igual
		  s_major_igual
		  s_distint	  

%left s_mes
	  s_menys

%left s_producte
	  s_divisio
	  s_mod

%with decls.datribut;
%use decls.datribut;
{
subtype YYSType is atribut; 
}

%%

S:
	PROGRAMA
;

PROGRAMA: 
	pc_procedure ENCAP pc_is
		DECLARACIONS	
	pc_begin
		SENTENCIES
	pc_end identificador s_punt_i_coma
;

ENCAP:
	  identificador
	| PRMB_ENCAP s_parentesi_tancat
;

PRMB_ENCAP:
	  PRMB_ENCAP s_punt_i_coma PARAMETRE
	| identificador s_parentesi_obert PARAMETRE
;

PARAMETRE:
	identificador s_dos_punts MODE identificador
;

MODE:
	  pc_in
	| pc_out
	| pc_in pc_out
;

DECLARACIONS:
      DECLARACIO DECLARACIONS
	| 
;

DECLARACIO:
	  DEC_CONST
	| DEC_VAR
	| DEC_PROCEDURE
	| DEC_TIPUS
;

DEC_TIPUS:
	  DEC_ARRAY
	| DEC_RECORD
	| DEC_SUBRANG
;

DEC_CONST:
	identificador s_dos_punts pc_constant identificador s_assignacio V_CONST s_punt_i_coma
;

V_CONST:
	  s_mes literal
	| s_menys literal
	| literal
;
	
DEC_VAR:
	identificador C_DECL_VAR
; 	  

C_DECL_VAR:
	  s_dos_punts identificador s_punt_i_coma
	| s_coma identificador C_DECL_VAR
;

DEC_ARRAY:
	PRMB_DECL_ARRAY s_parentesi_tancat pc_of identificador s_punt_i_coma
;

PRMB_DECL_ARRAY:
      PRMB_DECL_ARRAY s_coma RANG 
	| pc_type identificador pc_is pc_array s_parentesi_obert RANG
;

RANG: 
	LIM s_puntpunt LIM
;

LIM:
	  identificador
	| literal
;

DEC_PROCEDURE:
	PROGRAMA
;

DEC_RECORD:
	PRMB_DECL_RECORD pc_end pc_record s_punt_i_coma
;

PRMB_DECL_RECORD:
	  pc_type identificador pc_is pc_record identificador s_dos_punts identificador s_punt_i_coma
	| PRMB_DECL_RECORD identificador s_dos_punts identificador s_punt_i_coma
;

DEC_SUBRANG:
	pc_type identificador pc_is pc_new identificador pc_range RANG s_punt_i_coma	
;

SENTENCIES:
      SENTENCIA SENTENCIES
	| SENTENCIA
;

SENTENCIA:
 	  SENT_FLUXE
	| SENT_BUCLES
	| SENT_ASSIGNACIO
	| SENT_PROCEDURE
;

SENT_FLUXE:
	  pc_if EXPRESIO pc_then SENTENCIES pc_end pc_if s_punt_i_coma
	| pc_if EXPRESIO pc_then SENTENCIES pc_else SENTENCIES pc_end pc_if s_punt_i_coma
;	

SENT_BUCLES:
	  pc_while EXPRESIO pc_loop SENTENCIES pc_end pc_loop s_punt_i_coma
	| pc_for identificador pc_in RANG pc_loop SENTENCIES pc_end pc_loop s_punt_i_coma
;

EXPRESIO: 
	  EXPRESIO pc_and EXPRESIO
	| EXPRESIO pc_or EXPRESIO
	| EXPRESIO s_major EXPRESIO
	| EXPRESIO s_menor EXPRESIO
	| EXPRESIO s_major_igual EXPRESIO
	| EXPRESIO s_menor_igual EXPRESIO
	| EXPRESIO s_igual EXPRESIO
	| EXPRESIO s_distint EXPRESIO
	| EXPRESIO s_mes EXPRESIO
	| EXPRESIO s_menys EXPRESIO
	| EXPRESIO s_producte EXPRESIO
	| EXPRESIO s_divisio EXPRESIO
	| EXPRESIO s_mod EXPRESIO
	| s_menys EXPRESIO
	| s_parentesi_obert EXPRESIO s_parentesi_tancat
	| literal 
	| R
; 

R: 
	  R s_punt identificador 
	| PRMB_A s_parentesi_tancat
	| identificador
;

PRMB_A:
	  PRMB_A s_coma EXPRESIO
	| R s_parentesi_obert EXPRESIO
;
	
SENT_ASSIGNACIO:
	R s_assignacio EXPRESIO s_punt_i_coma
;

SENT_PROCEDURE:
	R s_punt_i_coma
;


%%

package analitzador_sintactic is
	Error_sintactic: exception; 
	procedure yyparse;
end analitzador_sintactic;

with ada.text_io; use ada.text_io;
with decls.generals, decls.datribut; use decls.generals, decls.datribut; 
with a_lexic, lexic_dfa, lexic_io; use a_lexic, lexic_dfa, lexic_io;
with sintactic_tokens, sintactic_goto; use sintactic_tokens, sintactic_goto;
with sintactic_shift_reduce; use sintactic_shift_reduce;

package body analitzador_sintactic is

	procedure yyerror(s: in string) is
    begin
 		put_line("Error de sintaxi. Lin: " & natural'image(yylval.lin) & " Col: " & natural'image(yylval.col));
	    raise Error_sintactic;
    end yyerror;
##
end analitzador_sintactic;
