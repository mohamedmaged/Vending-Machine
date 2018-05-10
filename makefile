all : syf boom boog loon scan
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

loon: statea_b.xsc statej_b.xsc statem_b.xsc stateo_b.xsc stater_b.xsc
statea_b.xsc : statea_b.vst
	@echo " Optimizing -a -> $@ "
	loon statea_b statea_l param
statej_b.xsc : statej_b.vst
	@echo " Optimizing -j -> $@ "
	loon statej_b statej_l param
statem_b.xsc : statem_b.vst
	@echo " Optimizing -m -> $@ "
	loon statem_b statem_l param
stateo_b.xsc : stateo_b.vst
	@echo " Optimizing -o -> $@ "
	loon stateo_b stateo_l param
stater_b.xsc : stater_b.vst
	@echo " Optimizing -r -> $@ "
	loon stater_b stater_l param

registers:
	cat state*_l.vst | grep sff

scan : scano.path scanj.path
	@echo " scan-path insertion -> $@ "
	scapin -VRB stateo_l scano stateo_l_scan > scapino.out
	scapin -VRB statej_l scanj statej_l_scan > scapinj.out

%_l_flat :
	flatbeh $*_l $*_flat
	proof -d $*_flat $*

stateo_p.ap :
	MBK_IN_LO=vst; export MBK_IN_LO; \
	MBK_OUT_PH=ap; export MBK_OUT_PH; \
	ocp –v –ring –ioc xx.ioc stateo_l_scan stateo_p   
statej_p:
	ocp –v –ring –ioc xx.ioc statej_l_scan statej_p

graal:
	RDS_TECHNO_NAME=techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal
stateo_r:
	nero -V -p stateo_p stateo_l_scan stateo_l_scan
statej_r:
	nero -V -p statej_p statej_l_scan statej_l_scan
cougaro:
	MBK_OUT_LO=al; export MBK_OUT_LO; \
	RDS_TECHNO_NAME=./techno/techno-035.rds; export RDS_TECHNO_NAME; \
	cougar -v stateo_l_scan stateo_c
	lvx vst al stateo_l_scan stateo_c -f
druco:
	RDS_TECHNO_NAME=./techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	druc stateo_l_scan 

state_chip:
	RDS_TECHNO_NAME=./techno/techno-035.rds; export RDS_TECHNO_NAME; \
	RDS_OUT=cif; export RDS_OUT; \
	s2r -v -r stateo_l_scan > s2r.out
dreal:
	RDS_TECHNO_NAME=./techno/techno-035.rds; export RDS_TECHNO_NAME; \
	dreal -1 stateo_l_scan
	



	
