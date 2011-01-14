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
      
%with decls.crea_arbre, decls.nodes_arbre;
%use decls.crea_arbre, decls.nodes_arbre;
{
subtype YYSType is ast; 
}

%%

PROGRAMA: 
	  DEC_PROC
	  {rs_programa($1);}
        ;

DEC_PROC:
        pc_procedure ENCAP pc_is
                DECLARACIONS
        pc_begin
                SENTENCIES
        pc_end identificador s_punt_i_coma
        {rs_dec_proc($$, $2, $4, $6, $8);}
        ;

ENCAP:
          identificador
	{rs_encap($$, $1);}
        | identificador s_parentesi_obert PARAMETRES s_parentesi_tancat
	{rs_encap($$, $1, $3);}
        ;

PARAMETRES:
          PARAMETRES s_punt_i_coma PARAMETRE
	{rs_parametres($$, $1, $3);}
        | PARAMETRE
	{rs_parametres($$, $1);}
        ;
        
PARAMETRE:
          identificador s_dos_punts MODE identificador
	{rs_parametre($$, $1, $4, $3);}
        ;

MODE:
          pc_in
	  {rs_mode($$, m_in);}
        | pc_out
	  {rs_mode($$, m_out);}
        | pc_in pc_out
	  {rs_mode($$, m_in_out);}
        ;

DECLARACIONS: 
	  DECLARACIONS DECLARACIO
	  {rs_declaracions($$, $1, $2);}
        | 
	  {rs_declaracions($$);}
        ;

DECLARACIO:
          DEC_CONST
	  {rs_declaracio($$, $1);}
        | DEC_VAR
	  {rs_declaracio($$, $1);}
        | DEC_PROC
	  {rs_declaracio($$, $1);}
        | DEC_TIPUS
	  {rs_declaracio($$, $1);}
        ;

DEC_TIPUS:
          DEC_ARRAY
	  {rs_dec_tipus($$, $1);}
        | DEC_RECORD
	  {rs_dec_tipus($$, $1);}
        | DEC_SUBRANG
	  {rs_dec_tipus($$, $1);}
        ;

DEC_CONST: 
	  LLISTA_ID s_dos_punts pc_constant identificador s_assignacio V_CONST s_punt_i_coma
	  {rs_dec_const($$, $1, $6, $4);}
	;

V_CONST:
          s_menys literal
	  {rs_vconst($$, $2, o_menys_unitari);}
        | literal
	  {rs_vconst($$, $1);}
        ;

DEC_VAR: 
          LLISTA_ID s_dos_punts identificador s_punt_i_coma
          {rs_dec_var($$, $3, $1);}
        ;

DEC_ARRAY: 
	  pc_type identificador pc_is pc_array s_parentesi_obert LLISTA_ID s_parentesi_tancat pc_of identificador s_punt_i_coma
	  {rs_dec_array($$, $2, $6, $9);}
	;

LLISTA_ID:
	  LLISTA_ID s_coma identificador
	  {rs_llista_id($$, $3, $1);}
	| identificador
	  {rs_llista_id($$, $1);}
	;

DEC_RECORD: 
          pc_type identificador pc_is pc_record CAMPS pc_end pc_record s_punt_i_coma
          {rs_dec_record($$, $2, $5);}
	;
        
CAMPS:
	  CAMPS CAMP
	  {rs_camps($$, $2, $1);}
	| CAMP
	  {rs_camps($$, $1);}
	;
      
CAMP:
	  identificador s_dos_punts identificador s_punt_i_coma
	  {rs_camp($$, $1, $2);}
	;

DEC_SUBRANG:
          pc_type identificador pc_is pc_new identificador pc_range RANG s_punt_i_coma
          {rs_dec_subrang($$, $2, $5, $7);}
        ;

RANG: 
          LIM s_puntpunt LIM
          {rs_rang($$, $1, $3);}
        ;

LIM:    
          identificador
          {rs_lim($$, $1);}
        | s_menys identificador
          {rs_lim($$, $2, o_menys_unitari);}
        | s_menys literal
          {rs_lim($$, $2, o_menys_unitari);}
        | literal
          {rs_lim($$, $1);}
        ;

SENTENCIES:
          SENTENCIES SENTENCIA
          {rs_sentencies($$, $2, $1);}
        | SENTENCIA
          {rs_sentencies($$, $1);}
        ;

SENTENCIA: 
          SENT_BUCLES
          {rs_sentencia($$, $1);}
        | SENT_FLUXE
          {rs_sentencia($$, $1);}
        | SENT_PROCEDURE
          {rs_sentencia($$, $1);}
        | SENT_ASSIGNACIO
          {rs_sentencia($$, $1);}
        ;

SENT_BUCLES: 
	  pc_while EXPRESSIO pc_loop SENTENCIES pc_end pc_loop s_punt_i_coma
	  {rs_sent_bucles($$, $2, $4);}
	;
        
SENT_FLUXE:
          pc_if EXPRESSIO pc_then SENTENCIES pc_end pc_if s_punt_i_coma
          {rs_sent_fluxe($$, $2, $4, null);}
        | pc_if EXPRESSIO pc_then SENTENCIES pc_else SENTENCIES pc_end pc_if s_punt_i_coma
          {rs_sent_fluxe($$, $2, $4, $6);}
        ;

EXPRESSIO:
          EXPRESSIO pc_and EXPRESSIO
          {rs_expressio($$, $1, $2, o_and);}
        | EXPRESSIO pc_or EXPRESSIO
          {rs_expressio($$, $1, $2, o_or);}
        | EXPRESSIO s_major EXPRESSIO
          {rs_expressio($$, $1, $2, o_major);}
        | EXPRESSIO s_menor EXPRESSIO
          {rs_expressio($$, $1, $2, o_menor);}
        | EXPRESSIO s_major_igual EXPRESSIO
          {rs_expressio($$, $1, $2, o_major_igual);}
        | EXPRESSIO s_menor_igual EXPRESSIO
          {rs_expressio($$, $1, $2, o_menor_igual);}
        | EXPRESSIO s_igual EXPRESSIO
          {rs_expressio($$, $1, $2, o_igual);}
        | EXPRESSIO s_diferent EXPRESSIO
          {rs_expressio($$, $1, $2, o_diferent);}
        | EXPRESSIO s_mes EXPRESSIO
          {rs_expressio($$, $1, $2, o_mes);}
        | EXPRESSIO s_menys EXPRESSIO
          {rs_expressio($$, $1, $2, o_menys);}
        | EXPRESSIO s_producte EXPRESSIO
          {rs_expressio($$, $1, $2, o_producte);}
        | EXPRESSIO s_divisio EXPRESSIO
          {rs_expressio($$, $1, $2, o_divisio);}
        | EXPRESSIO s_modul EXPRESSIO
          {rs_expressio($$, $1, $2, o_modul);}
        | pc_not EXPRESSIO %prec s_menys
          {rs_expressio($$, $1, $2, o_not);}
        | s_menys EXPRESSIO 
          {rs_expressio($$, $1, null, o_menys_unitari);}
        | s_parentesi_obert EXPRESSIO s_parentesi_tancat
          {rs_expressio($$, $2);}
        | REF
          {rs_expressio($$, $1);}
        | literal
          {rs_expressio($$, $1);}
        ;

REF: 
	  identificador
	  {rs_ref($$, $1);}
	| REF s_punt identificador
	  {rs_ref($$, $3, $1);}
	| REF_COMP s_parentesi_tancat
	  {rs_ref($$, $1);}
	;

REF_COMP:
	  REF_COMP s_coma EXPRESSIO
	  {rs_ref_comp($$, $3, $1);}
	| REF s_parentesi_obert EXPRESSIO
	  {rs_ref_comp($$, $3, $1);} --TODO revisar si es la mateixa funcio
	;    

SENT_ASSIGNACIO: 
	  REF s_assignacio EXPRESSIO s_punt_i_coma
	  {rs_sent_assignacio($$, $1, $3);}
	;

SENT_PROCEDURE: 
	  REF s_punt_i_coma
	  {rs_sent_procedure($$, $1);}
	;
                           
%%

package analitzador_sintactic is
    Error_sintactic: exception; 
    procedure yyparse;
end analitzador_sintactic;

with ada.text_io; use ada;
with decls.generals, decls.nodes_arbre, decls.crea_arbre;
use decls.generals, decls.nodes_arbre, decls.crea_arbre; 
with a_lexic, lexic_dfa, lexic_io; use a_lexic, lexic_dfa, lexic_io;
with sintactic_tokens, sintactic_goto, sintactic_shift_reduce;
use sintactic_tokens, sintactic_goto, sintactic_shift_reduce;
package body analitzador_sintactic is

    procedure yyerror(s: in string) is
    begin
        --text_io.put_line("Error de sintaxi. Lin: " & natural'image(yylval.lin) & " Col: " & natural'image(yylval.col));
		raise Error_sintactic;
    end yyerror;
##
end analitzador_sintactic;
