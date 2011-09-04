package body semantica.missatges is

	function valor(io: in tipus_md) return string is
	begin
		if io = inici then
			return "Inici";
		else
			return "Final";
		end if;
	end valor;

	--misatges de depuracio
	procedure md_dec_param(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio parametre";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_param; 

	procedure md_dec_params(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio parametres";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_params;  

	procedure md_vconst(io: in tipus_md) is
		m: string := valor(io) & " ct valor constant";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_vconst;

	procedure md_dec_const(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio constant";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_const;

   procedure md_dec_variable(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio variable";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_variable;

   procedure md_rang(io: in tipus_md) is
		m: string := valor(io) & " ct rang";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_rang;
 
	procedure md_dec_subrang(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio subrang";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_subrang;
   
   procedure md_idx_array(io: in tipus_md) is
		m: string := valor(io) & " ct index array";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_idx_array;

	procedure md_dec_array(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio array";	
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_array;

	procedure md_camps_rec(io: in tipus_md) is
		m: string := valor(io) & " ct camps record";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_camps_rec;

 	procedure md_dec_rec(io: in tipus_md) is
		m: string := valor(io) & " ct declaracio record";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_dec_rec;

	procedure md_decs(io: in tipus_md) is
		m: string := valor(io) & " ct declaracions";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_decs;

   procedure md_identif(io: in tipus_md) is
		m: string := valor(io) & " ct identificador"; 
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_identif;

   procedure md_index(io: in tipus_md) is
		m: string := valor(io) & " ct index";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_index;

	procedure md_ref_comp(io: in tipus_md) is
		m: string := valor(io) & " ct referencia composta";
	begin
		if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_ref_comp;

   procedure md_ref(io: in tipus_md) is
		m: string := valor(io) & " ct referencia";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
         else
	         put_line(m);
	      end if;
		end if;
	end md_ref;

 	procedure md_exp(io: in tipus_md) is
		m: string := valor(io) & " ct expresio";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_exp;

	procedure md_sent_buc(io: in tipus_md) is
		m: string := valor(io) & " ct sentencia bucle";
	begin	
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_sent_buc;

   procedure md_sent_fluxe(io: in tipus_md) is
		m: string := valor(io) & " ct sentencia fluxe";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;

	end md_sent_fluxe;

   procedure md_sent_assig(io: in tipus_md) is
		m: string := valor(io) & " ct sentencia assignacio";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_sent_assig;
 
	procedure md_param(io: in tipus_md) is
		m: string := valor(io) & " ct parametre";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_param;
          
   procedure md_params_proc(io: in tipus_md) is
		m: string := valor(io) & " ct parametres procediment";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_params_proc;

	procedure md_sent_proc(io: in tipus_md) is
		m: string := valor(io) & " ct sentencia procediment";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
	end md_sent_proc;

	procedure md_sents(io: in tipus_md) is
		m: string := valor(io) & " ct sentencies";
	begin
		if mode_depuracio then
		   if mode_log then
			   put_line(log, m);
			else
	   	   put_line(m);
	   	end if;
		end if;
	end md_sents;

   procedure md_dec_proc(io: in tipus_md) is
		m: string := valor(io) & " ct declaració de procediment";
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, m);
			else
	         put_line(m);
	      end if;
		end if;
   end md_dec_proc;

	procedure md_comprovacio_tipus(io: in tipus_md) is
		m: string := valor(io) & " de la comprovació de tipus";	
	begin
	   if mode_depuracio then	     
			if mode_log then
	         put_line(log, m);
         else
            put_line(m);
         end if;
      end if;
   end md_comprovacio_tipus;

   procedure prepara_log(nom: in string) is
   begin
      if mode_log then
         create(log, out_file, nom & ".log");
      end if;
   end prepara_log;

   procedure finalitza_log is
   begin
      if mode_log then
         close(log);
      end if;
   end finalitza_log;

end semantica.missatges;
