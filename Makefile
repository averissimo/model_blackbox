# mcc file location
MCC = /opt/MATLAB/R2013a/bin/mcc

MODELS_ODE = models/differential
MODELS_ALG = models/algebraic
INC = $(subst models,-I models,$(wildcard $(MODELS_ODE)/*)) $(subst models,-I models,$(wildcard $(MODELS_ALG)/*))
LIB = toolbox/src

ZWIET = toolbox/src/zwietering

ESTS_PATH = cgi/matlab/estimators
SIMS_PATH = cgi/matlab/simulators

# toolboxes /path/to/SBPD/SBT2/and/jsonlab
MFLAGS = -m -I $(LIB) -I $(ZWIET) $(INC) -R -nodisplay -R -nojvm

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
	chmod +x wrapper_temp

clean:
	rm -f wrapper_temp.m *.log *.c *.sh *.prj readme.txt

# MATLAB

# All models
############################

gompertza: gompertza_est gompertza_sim

logisticsa: logisticsa_est logisticsa_sim

baranyia: baranyia_est baranyia_sim

hyperbolastica: hyperbolastica_est hyperbolastica_sim

reversible_hills_equationa: reversible_hills_equationa_est reversible_hills_equationa_sim

richardsa: richardsa_est richardsa_sim

schnutea: schnutea_est schnutea_sim

live_cello: live_cello_est live_cello_sim

monomoreo: monomoreo_est monomoreo_sim

#
# Pattern rules
#

%_est:
	make wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(ESTS_PATH)/$(subst _est,,$@).cgi

%_sim:
	make wrapper_cp
	echo "str = $@();" >> wrapper_temp.m
	make wrapper_temp
	mv wrapper_temp $(SIMS_PATH)/$(subst _sim,,$@).cgi
