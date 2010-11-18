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
	

