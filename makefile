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

boog: statea_b.vst statej_b.vst statem_b.vst stateo_b.vst stater_b.vst
statea_b.vst : statea_b.vbe
	@echo " Optimizing -a -> $@ "
	boog -l param statea_b
statej_b.vst : statej_b.vbe
	@echo " Optimizing -j -> $@ "
	boog -l param statej_b
statem_b.vst : statem_b.vbe
	@echo " Optimizing -m -> $@ "
	boog -l param statem_b
stateo_b.vst : stateo_b.vbe
	@echo " Optimizing -o -> $@ "
	boog -l param stateo_b
stater_b.vst : stater_b.vbe
	@echo " Optimizing -r -> $@ "
	boog -l param stater_b
