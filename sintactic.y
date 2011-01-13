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
		
%nonassoc pc_and
          pc_or 

%nonassoc s_igual
          s_menor
          s_major
          s_menor_igual
          s_major_igual
          s_diferent	  

%left s_mes
      s_menys

%left s_producte
      s_divisio
      s_modul
      
%with decls.datribut;
%use decls.datribut;
{
subtype YYSType is pnode; 
}

%%

DEC_PROC:
        pc_procedure ENCAP pc_is
                DECLARACIONS
        pc_begin
                SENTENCIES
        pc_end identificador s_punt_i_coma
        {crea_n_dec_proc($$,$2,$4,$6,$8);}
        ;

ENCAP:
          identificador
	{crea_n_encap($$,$1,null);}
        | identificador s_parentesi_obert PARAMETRES s_parentesi_tancat
	{crea_n_encap($$,$1,$3);}
        ;

PARAMETRES:
          PARAMETRES s_punt_i_coma PARAMETRE
	{crea_n_dec_params($$,$1,$3);}
        | PARAMETRE
	{crea_n_dec_params($$,null,$1);}
        ;
        
PARAMETRE:
          identificador s_dos_punts MODE identificador
	{crea_n_dec_param($$,$1,$4,$3);}
        ;

MODE:
          pc_in
      {crea_n_dec_mode($$,m_in);}
        | pc_out
      {crea_n_dec_mode($$,m_out);}
        | pc_in pc_out
      {crea_n_dec_mode($$,m_in_out);}
        ;

DECLARACIONS: 
	  DECLARACIONS DECLARACIO
	{crea_n_decs($$,$1,$2);}
        | 
	{remunta_decs($$);}
        ;

DECLARACIO:
          DEC_CONST
	{remunta_dec($$,$1);}
        | DEC_VAR
	{remunta_dec($$,$1);}
        | DEC_PROC
	{remunta_dec($$,$1);}
        | DEC_TIPUS
	{remunta_dec($$,$1);}
        ;

DEC_TIPUS:
          DEC_ARRAY
	{remunta_dec($$,$1);}
        | DEC_RECORD
	{remunta_dec($$,$1);}
        | DEC_SUBRANG
	{remunta_dec($$,$1);}
        ;

DEC_CONST: 
	LLISTA_ID s_dos_punts pc_constant identificador s_assignacio V_CONST s_punt_i_coma
	{remunta_dec($$,$1,$4,$6);}
	;

V_CONST:
          s_menys literal
	{remunta_vconst($$,$2,s_menys);}
        | literal
	{remunta_vconst($$,$1,null);}
        ;

DEC_VAR: 
        LLISTA_ID s_dos_punts identificador s_punt_i_coma
        ;

DEC_ARRAY: 
	pc_type identificador pc_is pc_array s_parentesi_obert LLISTA_ID s_parentesi_tancat pc_of identificador s_punt_i_coma
	;

LLISTA_ID:
	  LLISTA_ID s_coma identificador
	| identificador
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
          EXPRESSIO pc_and EXPRESSIO
        | EXPRESSIO pc_or EXPRESSIO
        | EXPRESSIO s_major EXPRESSIO
        | EXPRESSIO s_menor EXPRESSIO
        | EXPRESSIO s_major_igual EXPRESSIO
        | EXPRESSIO s_menor_igual EXPRESSIO
        | EXPRESSIO s_igual EXPRESSIO
        | EXPRESSIO s_diferent EXPRESSIO
        | EXPRESSIO s_mes EXPRESSIO
        | EXPRESSIO s_menys EXPRESSIO
        | EXPRESSIO s_producte EXPRESSIO
        | EXPRESSIO s_divisio EXPRESSIO
        | EXPRESSIO s_modul EXPRESSIO
        | pc_not EXPRESSIO %prec s_menys
        | s_menys EXPRESSIO 
        | s_parentesi_obert EXPRESSIO s_parentesi_tancat
        | REF
        | literal
        ;

REF: 
	  identificador	
	| REF s_punt identificador
	| REF_COMP s_parentesi_tancat    
	;

REF_COMP:
	  REF_COMP s_coma EXPRESSIO
	| REF s_parentesi_obert EXPRESSIO
	;    

SENT_ASSIGNACIO: 
	REF s_assignacio EXPRESSIO s_punt_i_coma
	;

SENT_PROCEDURE: 
	REF s_punt_i_coma
	;
                           
%%

package analitzador_sintactic is
    Error_sintactic: exception; 
    procedure yyparse;
end analitzador_sintactic;

with ada.text_io; use ada;
with decls.generals, decls.datribut; use decls.generals, decls.datribut; 
with a_lexic, lexic_dfa, lexic_io; use a_lexic, lexic_dfa, lexic_io;
with sintactic_tokens, sintactic_goto, sintactic_shift_reduce; use sintactic_tokens, sintactic_goto, sintactic_shift_reduce;
package body analitzador_sintactic is

    procedure yyerror(s: in string) is
    begin
        text_io.put_line("Error de sintaxi. Lin: " & natural'image(yylval.lin) & " Col: " & natural'image(yylval.col));
		raise Error_sintactic;
    end yyerror;
##
end analitzador_sintactic;
