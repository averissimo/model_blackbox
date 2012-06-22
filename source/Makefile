all: remote_estimation clean

remote_estimation: remote_estimation.m
	/usr/local/mathlab/bin/mcc -m -I /home/dev/work/pneumosys/matlab/standalone_estimation/models -I /home/dev/work/pneumosys/matlab/standalone_estimation/lib -R -nodisplay -R -nojvm remote_estimation.m
#	/usr/local/mathlab/bin/mcc -m -v -R -nodisplay -R -nojvm remote_estimation.m
	mv remote_estimation script.cgi


full_clean: clean
	rm script.cgi

clean:
	rm mccExcludedFiles.log remote_estimation_main.c run_remote_estimation.sh remote_estimation.prj remote_estimation_mcc_component_data.c readme.txt
