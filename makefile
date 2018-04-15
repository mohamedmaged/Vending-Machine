syf : statea.vbe statej.vbe statem.vbe stateo.vbe stater.vbe
statea.vbe : state.fsm
	@echo " Encoding -a -> $@ "
	syf -CEV -a state.fsm
statej.vbe : state.fsm
	@echo " Encoding -j -> $@ "
	syf -CEV -j state.fsm
statem.vbe : state.fsm
	@echo " Encoding -m -> $@ "
	syf -CEV -m state.fsm
stateo.vbe : state.fsm
	@echo " Encoding -o -> $@ "
	syf -CEV -o state.fsm
stater.vbe : state.fsm
	@echo " Encoding -r -> $@ "
	syf -CEV -r state.fsm
boom : statea_b.vbe statej_b.vbe statem_b.vbe stateo_b.vbe stater_b.vbe
statea_b.vbe : statea.vbe
	@echo " Optimizing -a -> $@ "
	boom -V -d 50 statea.vbe statea_b
statej_b.vbe : statej.vbe
	@echo " Optimizing -j -> $@ "
	boom -V -d 50 statej.vbe statej_b
statem_b.vbe : statem.vbe
	@echo " Optimizing -m -> $@ "
	boom -V -d 50 statem.vbe statem_b
stateo_b.vbe : stateo.vbe
	@echo " Optimizing -o -> $@ "
	boom -V -d 50 stateo.vbe stateo_b
stater_b.vbe : stater.vbe
	@echo " Optimizing -r -> $@ "
	boom -V -d 50 stater.vbe stater_b



