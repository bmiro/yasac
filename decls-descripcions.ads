with decls.generals; use decls.generals;
package decls.descripcions is

	type it_index is new natural range 0..maxid;
	type it_param is new natural range 0..maxid;

	type tipus_descripcio is (d_nul, d_const, d_var, d_tipus, d_proc);
	type tipus_sub is (tsnul, tsbool, tscar, tsenter, tsrec, tsarray);

	type descr_tipus(tsub: tipus_sub := tsnul) is
		record
			ocup: natural;
			case tsub is
				when tsnul => null;
				when tsbool | tscar | tsenter => linf, lsup: valor;
												  tpare: id_nom;
				when tsarray => tcomp: id_nom; 
				when tsrec => id_rec: id_nom;
				when others => null;
			end case;
		end record;

	type descripcio(td: tipus_descripcio := d_nul) is
		record
			case td is
				when d_nul => null;
				when d_const => tyc: id_nom;
								 vc: valor;
				when d_var => tyv: id_nom;
							   nv: natural; 
				when d_tipus => dt: descr_tipus;  
				when d_proc => np: natural;		
			end case;
		end record;

end decls.descripcions;
