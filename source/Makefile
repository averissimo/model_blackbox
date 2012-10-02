# mcc file location
MCC = /opt/R2010a/bin/mcc

# toolboxes /path/to/SBPD/SBT2/and/jsonlab
MFLAGS =  -m -I auxiliary -I /home/averissimo/work/toolboxes -I models -I models_ode -I models_analytical -I lib -R -nodisplay -R -nojvm

YADA = estimators_analytical/testa_est.m estimators_ode/testo_est.m

all: gompertz baranyi gompertza baranyia logistica richardsa schnutea clean


test: estimators_analytical/test.m
	$(MCC) $(MFLAGS) estimators_analytical/test.m
	mv test ../estimators/test.cgi

RUBY = ruby


# OCTAVE

octave:
	$(RUBY) octave_cgi.rb

# MATLAB


# Gompertz (SBT2)
#############################

gompertz: gompertz_est gompertz_sim

gompertz_est: estimators/gompertz_est.m
	$(MCC) $(MFLAGS) estimators/gompertz_est.m
	mv gompertz_est ../estimators/gompertz.cgi

gompertz_sim: simulators/gompertz_sim.m
	$(MCC) $(MFLAGS) simulators/gompertz_sim.m
	mv gompertz_sim ../simulators/gompertz.cgi

# Baranyi (SBT2)
#############################

baranyi: baranyi_est baranyi_sim

baranyi_est: estimators/baranyi_est.m
	$(MCC) $(MFLAGS) estimators/baranyi_est.m
	mv baranyi_est ../estimators/baranyi.cgi

baranyi_sim: simulators/baranyi_sim.m
	$(MCC) $(MFLAGS) simulators/baranyi_sim.m
	mv baranyi_sim ../simulators/baranyi.cgi

# Gompertz (analytical)
############################

gompertza: gompertza_est gompertza_sim

gompertza_est: estimators_analytical/gompertza_est.m
	$(MCC) $(MFLAGS) estimators_analytical/gompertza_est.m
	mv gompertza_est ../estimators/gompertza.cgi

gompertza_sim: simulators_analytical/gompertza_sim.m
	$(MCC) $(MFLAGS) simulators_analytical/gompertza_sim.m
	mv gompertza_sim ../simulators/gompertza.cgi

# Logistic (analytical)
############################

logistica: logistica_est logistica_sim

logistica_est: estimators_analytical/logistica_est.m
	$(MCC) $(MFLAGS) estimators_analytical/logistica_est.m
	mv logistica_est ../estimators/logistica.cgi

logistica_sim: simulators_analytical/logistica_sim.m
	$(MCC) $(MFLAGS) simulators_analytical/logistica_sim.m
	mv logistica_sim ../simulators/logistica.cgi

# Baranyi (analytical)
############################

baranyia: baranyia_est baranyia_sim

baranyia_est: estimators_analytical/baranyia_est.m
	$(MCC) $(MFLAGS) estimators_analytical/baranyia_est.m
	mv baranyia_est ../estimators/baranyia.cgi

baranyia_sim: simulators_analytical/baranyia_sim.m
	$(MCC) $(MFLAGS) simulators_analytical/baranyia_sim.m
	mv baranyia_sim ../simulators/baranyia.cgi

# Richards (analytical)
############################

richardsa: richardsa_est richardsa_sim

richardsa_est: estimators_analytical/richardsa_est.m
	$(MCC) $(MFLAGS) estimators_analytical/richardsa_est.m
	mv richardsa_est ../estimators/richardsa.cgi

richardsa_sim: simulators_analytical/richardsa_sim.m
	$(MCC) $(MFLAGS) simulators_analytical/richardsa_sim.m
	mv richardsa_sim ../simulators/richardsa.cgi

# Schnute (analytical)
############################

schnutea: schnutea_est schnutea_sim

schnutea_est: estimators_analytical/schnutea_est.m
	$(MCC) $(MFLAGS) estimators_analytical/schnutea_est.m
	mv schnutea_est ../estimators/schnutea.cgi

schnutea_sim: simulators_analytical/schnutea_sim.m
	$(MCC) $(MFLAGS) simulators_analytical/schnutea_sim.m
	mv schnutea_sim ../simulators/schnutea.cgi

# Baranyi (ODE)
############################

baranyio: baranyio_est baranyio_sim

baranyio_est: estimators_ode/baranyio_est.m
	$(MCC) $(MFLAGS) estimators_ode/baranyio_est.m
	mv baranyio_est ../estimators/baranyio.cgi

baranyio_sim: simulators_ode/baranyio_sim.m
	$(MCC) $(MFLAGS) simulators_ode/baranyio_sim.m
	mv baranyio_sim ../simulators/baranyio.cgi

full_clean: clean
	rm script.cgi

clean:
	rm *.log *.c *.sh *.prj readme.txt
