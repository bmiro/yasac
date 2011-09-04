with ada.text_io, decls.generals, decls.descripcions;
use ada.text_io, decls.generals, decls.descripcions;

package decls.c3a is

   -- Conjunt d'instruccions de c3a
   type inst_c3a is (
     -- codis tres operands
     cons_idx, copia_idx, suma, resta, mult, div, modul, and_logic, or_logic,
     op_igual, op_desigual, op_menor, op_major, op_menorig, op_majorig,

     -- codis dos operads
     resta_unitaria, not_logic, copia, paramc,

     -- codis amb etiques com operands
     etiq, goto_op,

     -- codis de procediments
     rtn, call, preamb,

     -- codis d'un sol operand
     params
    );
   package inst_c3a_enum is new ada.text_io.enumeration_io(inst_c3a);


   -- Definició de la taula de variables
   type tipus_variable is (var, par, const, t_null);
   type variable (t_var: tipus_variable := t_null) is record
      case t_var is
         when t_null => null;
         when var | par =>
            proc: num_proc;
            ocup: natural;
            despl: integer;
            id: id_nom;
         when const =>
            val: valor;
            tsub: tipus_sub;
      end case;
   end record;
   type tvariables is array (num_var) of variable;
   package tipus_var_enum is new ada.text_io.enumeration_io(tipus_variable);

   procedure put_tv(tv: in tvariables; f: in file_type);
   procedure put_v(f: file_type; var_l: in variable);
   procedure put(file: in out file_type; var_l: in variable);

   -- Definició de la taula de procediments
   type tipus_procediment is (intern, extern, t_null);
   type procediment(t_proc: tipus_procediment:= t_null) is record
      n_params: natural;
      idproc: id_nom;
      case t_proc is
         when intern =>
            prof: num_prof;
            ocup: natural;
            et: num_etq;
         when extern =>
            idetq: id_nom;
         when others =>
            null;
      end case;
   end record;
  type tprocediments is array (num_proc) of procediment;
  procedure put_tp(tp: in tprocediments; f: in file_type);

  -- Instrucció de codi intermedi de c3a
  type ic3a is record
      codi: inst_c3a;
      op1, op2, op3: integer;
  end record;

  -- Procediments auxiliars de la taula de variables
  procedure posa_var(tv: in out tvariables;
                     nv: in num_var; var: in variable);
  function cons_var(tv: in tvariables; nv: in num_var) return variable;

  -- Procediments auxiliars de la taula de procediments
  procedure posa_proc(tp: in out tprocediments;
                      np: in num_proc; proc: in procediment);
  function cons_proc(tp: in tprocediments;
                     np: in num_proc) return procediment;

  function nova_etq return num_etq;

private

   etq: num_etq;

end decls.c3a;
