# mcc file location
MCC = /opt/MATLAB/R2013a/bin/mcc

MODELS_ODE_PATH = models/differential
MODELS_ALG_PATH = models/algebraic
LIBRARY = toolbox/lib
AUXILIARY = toolbox/src

ESTS_PATH = cgi/matlab/estimators
SIMS_PATH = cgi/matlab/simulators

DIFFERENTIAL = $(MODELS_ODE_PATH)
ALGEBRAIC = $(MODELS_ALG_PATH)

# toolboxes /path/to/SBPD/SBT2/and/jsonlab
MFLAGS =  -m -I $(AUXILIARY) -I $(MODELS_ODE_PATH) -I $(MODELS_ALG_PATH) -I $(LIBRARY) -R -nodisplay -R -nojvm

RUBY = ruby


# OCTAVE

octave:
	$(RUBY) octave_cgi.rb

#
# auxiliary targets
#
wrapper_cp:
	cp wrapper.m wrapper_temp.m

wrapper_temp:
	echo "fprintf(1,printHeader(0));" >> wrapper_temp.m
	echo "fprintf(1,str);" >> wrapper_temp.m
	$(MCC) $(MFLAGS) wrapper_temp.m

full_clean: clean
	rm script.cgi

clean:
	rm wrapper_temp.m *.log *.c *.sh *.prj readme.txt

# MATLAB

# Gompertz (analytical)
############################

gompertza: gompertza_est gompertza_sim

gompertza_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

gompertza_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Logistic (analytical)
############################

logistica: logistica_est logistica_sim

logistica_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

logistica_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Baranyi (analytical)
############################

baranyia: baranyia_est baranyia_sim

baranyia_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

baranyia_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Richards (analytical)
############################

richardsa: richardsa_est richardsa_sim

richardsa_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

richardsa_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Schnute (analytical)
############################

schnutea: schnutea_est schnutea_sim

schnutea_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

schnutea_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Live Cell (ODE)
############################

live_cell: live_cello_est live_cello_sim

live_cello_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

live_cello_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi

# Monomer (ODE)
############################

monomero: monomero_est monomero_sim

monomero_est: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

monomero_sim: wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi
