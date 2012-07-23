# mcc file location
MCC = /opt/R2010a/bin/mcc

# toolboxes /path/to/SBPD/SBT2/and/jsonlab
MFLAGS =  -m -I auxiliary -I /home/averissimo/work/toolboxes -I models -I lib -R -nodisplay -R -nojvm


all: gompertz baranyi clean

gompertz: gompertz_est gompertz_sim

baranyi: baranyi_est baranyi_sim

gompertz_est: estimators/gompertz_est.m
	$(MCC) $(MFLAGS) estimators/gompertz_est.m
	mv gompertz_est ../estimators/gompertz.cgi

baranyi_est: estimators/baranyi_est.m
	$(MCC) $(MFLAGS) estimators/baranyi_est.m
	mv baranyi_est ../estimators/baranyi.cgi

gompertz_sim: simulators/gompertz_sim.m
	$(MCC) $(MFLAGS) simulators/gompertz_sim.m
	mv gompertz_sim ../simulators/gompertz.cgi

baranyi_sim: simulators/baranyi_sim.m
	$(MCC) $(MFLAGS) simulators/baranyi_sim.m
	mv baranyi_sim ../simulators/baranyi.cgi

full_clean: clean
	rm script.cgi

clean:
	rm *.log *.c *.sh *.prj readme.txt
