all: aflex
	cp AFLEXNAT/aflex .
	./aflex -E lexic.l
	gnatchop -w lexic.a
	gnatchop -w lexic_dfa.a
	gnatchop -w lexic_io.a
	rm *.a
	rm aflex 	
	gnatmake principal.adb

aflex:
	cd AFLEXNAT && gnatmake aflex



principal: 
	gnatmake principal.adb
	./principal
	
tnoms:
	gnatmake proves_tnoms.adb
	./proves_tnoms

edit:
	kate decls.ads decls-datribut.adb decls-datribut.ads decls-dtnoms.adb decls-dtnoms.ads decls-generals.ads gramatica lexic.l Makefile

tar:
	tar cvjf compiladors_`date +%Y%m%d-%H%M`.tar.bz2 * --exclude=$(CURDIR)"/.git*"

clean:
	rm proves_tnoms &
	rm principal &
	rm *.o &
	rm *.ali &
	rm *~ &
	rm a_lexic.* &
	rm lexic_dfa.* &
	rm lexic_io.* &
	rm AFLEXNAT/aflex &
	rm AFLEXNAT/*.ali &
	rm AFLEXNAT/*.o &
	rm *.tar.bz2
