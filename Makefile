# mcc file location
MCC = /opt/R2010a/bin/mcc

TOOLBOXES = /home/averissimo/work/toolboxes
MODELS_SBT_PATH = toolbox/models
MODELS_ODE_PATH = models/differential
MODELS_ALG_PATH =  models/algebraic
LIBRARY = toolbox/lib
AUXILIARY = toolbox/src

DIFFERENTIAL = $(MODELS_ODE_PATH)
ALGEBRAIC = $(MODELS_ALG_PATH)

# toolboxes /path/to/SBPD/SBT2/and/jsonlab
MFLAGS =  -m -I $(AUXILIARY) -I $(TOOLBOXES) -I $(MODELS_SBT_PATH) -I $(MODELS_ODE_PATH) -I $(MODELS_ALG_PATH) -I $(LIBRARY) -R -nodisplay -R -nojvm

RUBY = ruby


# OCTAVE

octave:
	$(RUBY) octave_cgi.rb

# MATLAB

# Gompertz (SBT2)
#############################

gompertz: gompertz_est gompertz_sim

gompertz_est: toolbox/estimators/gompertz_est.m
	$(MCC) $(MFLAGS) toolbox/estimators/gompertz_est.m
	mv gompertz_est cgi/matlab/estimators/gompertz.cgi

gompertz_sim: toolbox/simulators/gompertz_sim.m
	$(MCC) $(MFLAGS) simulators/gompertz_sim.m
	mv gompertz_sim cgi/matlab/simulators/gompertz.cgi

# Baranyi (SBT2)
#############################

baranyi: baranyi_est baranyi_sim

baranyi_est: toolbox/estimators/baranyi_est.m
	$(MCC) $(MFLAGS) toolbox/estimators/baranyi_est.m
	mv baranyi_est cgi/matlab/estimators/baranyi.cgi

baranyi_sim: toolbox/simulators/baranyi_sim.m
	$(MCC) $(MFLAGS) toolbox/simulators/baranyi_sim.m
	mv baranyi_sim cgi/matlab/simulators/baranyi.cgi

# Gompertz (analytical)
############################

gompertza: gompertza_est gompertza_sim

gompertza_est: $(ALGEBRAIC)/gompertz/gompertza_est.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/gompertz/gompertza_est.m
	mv gompertza_est cgi/matlab/estimators/gompertza.cgi

gompertza_sim: $(ALGEBRAIC)/gompertz/gompertza_sim.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/gompertz/gompertza_sim.m
	mv gompertza_sim cgi/matlab/simulators/gompertza.cgi

# Logistic (analytical)
############################

logistica: logistica_est logistica_sim

logistica_est: $(ALGEBRAIC)/logistic/logistica_est.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/logistic/logistica_est.m
	mv logistica_est .cgi/matlab/estimators/logistica.cgi

logistica_sim: $(ALGEBRAIC)/logistic/logistica_sim.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/logistic/logistica_sim.m
	mv logistica_sim cgi/matlab/simulators/logistica.cgi

# Baranyi (analytical)
############################

baranyia: baranyia_est baranyia_sim

baranyia_est: $(ALGEBRAIC)/baranyi/baranyia_est.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/baranyi/baranyia_est.m
	mv baranyia_est cgi/matlab/estimators/baranyia.cgi

baranyia_sim: $(ALGEBRAIC)/baranyi/baranyia_sim.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/baranyi/baranyia_sim.m
	mv baranyia_sim cgi/matlab/simulators/baranyia.cgi

# Richards (analytical)
############################

richardsa: richardsa_est richardsa_sim

richardsa_est: $(ALGEBRAIC)/richards/richardsa_est.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/richards/richardsa_est.m
	mv richardsa_est cgi/matlab/estimators/richardsa.cgi

richardsa_sim: $(ALGEBRAIC)/richards/richardsa_sim.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/richards/richardsa_sim.m
	mv richardsa_sim cgi/matlab/simulators/richardsa.cgi

# Schnute (analytical)
############################

schnutea: schnutea_est schnutea_sim

schnutea_est: $(ALGEBRAIC)/schnute/schnutea_est.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/schnute/schnutea_est.m
	mv schnutea_est cgi/matlab/estimators/schnutea.cgi

schnutea_sim: $(ALGEBRAIC)/schnute/schnutea_sim.m
	$(MCC) $(MFLAGS) $(ALGEBRAIC)/schnute/schnutea_sim.m
	mv schnutea_sim cgi/matlab/simulators/schnutea.cgi

# Live Cell (ODE)
############################

live_cell: live_cello_est live_cello_sim

live_cello_est: $(DIFFERENTIAL)/live_cell/live_cello_est.m
	$(MCC) $(MFLAGS) $(DIFFERENTIAL)/live_cell/live_cello_est.m
	mv live_cello_est cgi/matlab/estimators/live_cello.cgi

live_cello_sim: $(DIFFERENTIAL)/live_cell/live_cello_sim.m
	$(MCC) $(MFLAGS) $(DIFFERENTIAL)/live_cell/live_cello_sim.m
	mv live_cello_sim cgi/matlab/simulators/live_cello.cgi

# Monomer (ODE)
############################

monomero: monomero_est monomero_sim

monomero_est: $(DIFFERENTIAL)/monomer/monomero_est.m
	$(MCC) $(MFLAGS) $(DIFFERENTIAL)/monomer/monomero_est.m
	mv monomero_est cgi/matlab/estimators/monomero.cgi

monomero_sim: $(DIFFERENTIAL)/monomer/monomero_sim.m
	$(MCC) $(MFLAGS) $(DIFFERENTIAL)/monomer/monomero_sim.m
	mv monomero_sim cgi/matlab/simulators/monomero.cgi

full_clean: clean
	rm script.cgi

clean:
	rm *.log *.c *.sh *.prj readme.txt
