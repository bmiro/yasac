with decls.generals; use decls.generals;    
package decls.dtnoms is
        
    type Tnoms is limited private; 
    
    procedure tbuida(tn: out Tnoms);
    procedure posa_id(tn: in out Tnoms; s: in string; id: out id_nom);
    procedure posa_cad(tn: in out Tnoms; s: in string; id: out id_string);
    function con_id(tn: in Tnoms; id: in id_nom) return string;
    function con_cad(tn: in Tnoms; id: in id_string) return string;
    
private

    subtype index_tcaracters is id_string;

    type taula_dispersio is array(0..tam_tdispersio) of id_nom;
    type taula_caracters is array(index_tcaracters) of character;
    type bloc is record
        ptblocs: id_nom;    --posicio que apunta dins la mateixa taula de blocs 
        ptcaracters: index_tcaracters;  --posicio que apunta a la taula de caracters
    end record;
    type taula_blocs is array(id_nom'first+1..id_nom'last) of bloc;    
    type Tnoms is record
        tdispersio: taula_dispersio;
        tcaracters: taula_caracters;
        tblocs: taula_blocs;
        idx_tblocs: id_nom;    --proxima posicio buida de la taula de blocs
        idx_tcaracters: index_tcaracters;  --proxima posicio buida de la taula de caracters
    end record;
            
end decls.dtnoms;
