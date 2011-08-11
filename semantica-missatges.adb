package body semantica.missatges is

	function valor(io: in tipus_md) return string is
	begin
		if io = inici then
			return "Inici";
		else
			return "Final";
		end if;
	end valor;

   procedure md_dec_proc(io: in tipus_md) is
	begin
		put_line(valor(io));
	   --if mode_depuracio then
	      --if mode_log then
	         --put_line(log, valor(io) &
 		       --    " comprovació de tipus declaració de procediment");
			--else
	         --put_line(valor(io) &
            --      " comprovació de tipus declaració de procediment");
	      --end if;
		--end if;
   end md_dec_proc;

	procedure md_main is
	begin
	   if mode_depuracio then
	      if mode_log then
	         put_line(log, "Inici de la comprovació de tipus");
         else
            put_line("Inici de la comprovació de tipus");
         end if;
      end if;
   end md_main;

   procedure prepara_log(proc: in string) is
   begin
      if mode_log then
         create(log, out_file, proc & ".log");
      end if;
   end prepara_log;

   procedure finalitza_log is
   begin
      if mode_log then
         close(log);
      end if;
   end finalitza_log;

end semantica.missatges;
