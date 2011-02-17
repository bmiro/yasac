with decls.generals; use decls.generals; 
with decls.descripcions; use decls.descripcions;
with decls.nodes_arbre; use decls.nodes_arbre;
with decls.dtsimbols; use decls.dtsimbols;
with ada.text_io; use ada.text_io;
package semantica.comprovacio_tipus is

   procedure comprova_tipus;

	Error_semantic: exception;

end semantica.comprovacio_tipus;
