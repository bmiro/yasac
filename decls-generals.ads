with decls; use decls;
package decls.generals is 

    maxid: constant natural := 1001;
    maxstr: constant natural := 1000;
    long_mitja_id: constant natural := 10;
    long_mitja_str: constant natural := 20;
    tam_tcaracters: constant natural := maxid*(long_mitja_id + 1) + maxstr*(long_mitja_str + 1);
    tam_tdispersio: constant natural := maxid;

    type id_nom is new natural range 0..maxid;
    subtype id_string is natural range 1..tam_tcaracters; --Sino tenim problemes al teclara tc com string si feim el new natural

end decls.generals;

