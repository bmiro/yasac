%token Error
%token End_Of_Input
%token lambda
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
%token pc_not
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
%token s_modul
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
%token s_diferent
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

PROGRAMA:
        pc_procedure ENCAP pc_is
                DECLARACIONS
        pc_begin
                SENTENCIES
        pc_end identificador s_punt_i_coma
        ;

ENCAP:
          identificador
        | identificador s_parentesi_obert PARAMETRES s_parentesi_tancat
        ;

PARAMETRES:
          PARAMETRES s_punt_i_coma PARAMETRE
        | PARAMETRE
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
               DECLARACIONS DECLARACIO
            | lambda
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
        | s_menys literal
        | literal
        ;

DEC_VAR: 
        LLISTA_ID s_dos_punts identificador s_punt_i_coma
        ;

LLISTA_ID:
            LLISTA_ID s_coma identificador
            | identificador
            ;

DEC_ARRAY: 
            pc_type identificador pc_is pc_array 
    s_parentesi_obert LLISTA_IDX s_parentesi_tancat pc_of identificador s_punt_i_coma
    ;

LLISTA_IDX: 
            LLISTA_IDX s_coma identificador
          | identificador
          ;

DEC_PROCEDURE: 
               PROGRAMA
               ;

DEC_RECORD: 
        pc_type identificador pc_is pc_record CAMPS pc_end pc_record s_punt_i_coma
        ;
        
CAMPS:
      CAMPS CAMP
      | CAMP
      ;
      
CAMP:
     identificador s_dos_punts identificador s_punt_i_coma
     ;

DEC_SUBRANG:
         pc_type identificador pc_is pc_new identificador pc_range RANG s_punt_i_coma
         ;

RANG: 
        LIM s_puntpunt LIM 
        ;

LIM:    
          identificador
        | s_menys identificador
        | s_menys literal
        | literal
        ;

SENTENCIES:
          SENTENCIES SENTENCIA
        | SENTENCIA
        ;

SENTENCIA: 
          SENT_BUCLES
        | SENT_FLUXE
        | SENT_PROCEDURE
        | SENT_ASSIGNACIO
        ;

SENT_BUCLES: 
          pc_while EXPRESSIO pc_loop SENTENCIES pc_end pc_loop s_punt_i_coma
          ;
        
SENT_FLUXE:
          pc_if EXPRESSIO pc_then SENTENCIES pc_end pc_if s_punt_i_coma
        | pc_if EXPRESSIO pc_then SENTENCIES pc_else SENTENCIES pc_end pc_if s_punt_i_coma
        ;

EXPRESSIO:
        pc_not EXPRESSIO
        | EXPRESSIO pc_and EXPRESSIO
        | EXPRESSIO pc_or EXPRESSIO
        | EXPRESSIO s_major EXPRESSIO
        | EXPRESSIO s_menor EXPRESSIO
        | EXPRESSIO s_major_igual EXPRESSIO
        | EXPRESSIO s_menor_igual EXPRESSIO
        | EXPRESSIO s_igual EXPRESSIO
        | EXPRESSIO s_diferent EXPRESSIO
        | EXPRESSIO s_producte EXPRESSIO
        | EXPRESSIO s_divisio EXPRESSIO
        | EXPRESSIO s_modul EXPRESSIO
        | s_menys EXPRESSIO
        | EXPRESSIO s_mes EXPRESSIO
        | EXPRESSIO s_menys EXPRESSIO
        | s_parentesi_obert EXPRESSIO s_parentesi_tancat
        | REF
        | literal
        ;


REF:
          REF s_punt REF
        | identificador REF_ARRAY
        ;

REF_ARRAY:
            REF_ARRAY s_parentesi_obert REF s_parentesi_tancat
          | literal
          | lambda
          ;
       

SENT_ASSIGNACIO: 
                  REF s_assignacio EXPRESSIO s_punt_i_coma
                  ;

SENT_PROCEDURE: 
                  identificador s_parentesi_obert PARAMS s_parentesi_tancat s_punt_i_coma
                  ;
                  
REF_PROC:
         identificador
         ;
         
PARAMS:
          PARAMS s_coma REF
        | REF
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
