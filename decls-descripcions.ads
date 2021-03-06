with decls.generals; use decls.generals;
with ada.text_io;
package decls.descripcions is

   type tipus_descripcio is (d_nul, d_const, d_var, d_tipus, d_proc, d_param, d_camp);
   type tipus_sub is (tsnul, tsbool, tscar, tsenter, tsstr, tsrec, tsarray);

	package tipus_sub_enum is new ada.text_io.enumeration_io(tipus_sub);

   type descr_tipus(tsub: tipus_sub := tsnul) is record
      ocup: natural;
      case tsub is
         when tsnul =>
            null;
         when tsbool | tscar | tsenter =>
            linf, lsup: valor;
            tpare: id_nom;
         when tsarray | tsstr =>
            tcomp: id_nom;
         when tsrec =>
            null;
         when others =>
            null;
      end case;
   end record;

	type descripcio(td: tipus_descripcio := d_nul) is record
      case td is
         when d_nul =>
            null;
         when d_const =>
            tyc: id_nom;
            vc: valor;
         when d_var =>
            tyv: id_nom;
            nv: num_var;
         when d_tipus =>
            dt: descr_tipus;
         when d_proc =>
            np: num_proc;
         when d_param =>
            tp: id_nom;
            mode: t_mode;
            n_param: num_var;
         when d_camp =>
            despl: natural; 
            tc: id_nom; 				
      end case;
   end record;

end decls.descripcions;
