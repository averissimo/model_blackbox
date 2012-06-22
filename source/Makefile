all: gompertz_est clean baranyi_est clean gompertz_sim clean baranyi_sim clean

gompertz_est: estimators/gompertz_est.m
	/usr/local/mathlab/bin/mcc -m -I models -I lib -R -nodisplay -R -nojvm estimators/gompertz_est.m
	mv gompertz_est ../estimators/gompertz.cgi

baranyi_est: estimators/baranyi_est.m
	/usr/local/mathlab/bin/mcc -m -I models -I lib -R -nodisplay -R -nojvm estimators/baranyi_est.m
	mv baranyi_est ../estimators/baranyi.cgi

gompertz_sim: simulators/gompertz_sim.m
	/usr/local/mathlab/bin/mcc -m -I lib -R -nodisplay -R -nojvm simulators/gompertz_sim.m
	mv gompertz_sim ../simulators/gompertz.cgi

baranyi_sim: simulators/baranyi_sim.m
	/usr/local/mathlab/bin/mcc -m -I lib -R -nodisplay -R -nojvm simulators/baranyi_sim.m
	mv baranyi_sim ../simulators/baranyi.cgi

full_clean: clean
	rm script.cgi

clean:
	rm *.log *.c *.sh *.prj readme.txt
