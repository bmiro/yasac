all: aflex ayacc
	cp AFLEXNAT/aflex .
	cp AYACCNAT/ayacc .
	./aflex -E lexic.l
	gnatchop -w lexic.a
	gnatchop -w lexic_dfa.a
	gnatchop -w lexic_io.a
	./ayacc sintactic.y off off on on
	gnatchop -w sintactic.a
	rm *.a
	rm aflex ayacc
	gnatmake principal.adb

aflex:
	cd AFLEXNAT && gnatmake aflex

ayacc:
	cd AYACCNAT && gnatmake ayacc

principal: 
	gnatmake principal.adb
	./principal
	
tnoms:
	gnatmake proves_tnoms.adb
	./proves_tnoms

tsimbols:
	gnatmake decls-dtsimbols.adb

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
	rm AYACCNAT/ayacc &
	rm AYACCNAT/*.ali &
	rm AYACCNAT/*.o &
	rm *.tar.bz2
