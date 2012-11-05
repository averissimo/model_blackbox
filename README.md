# == Model Blackbox ==

This matlab package intends to work as a blackbox for parameter estimation and model simulation

It supports three different backends:
* Octave (optim package)
* Matlab (optimization toolbox)
* Matlab (SBTOOLBOX2 toolbox)

We reccomend to use either Octave or Matlab own toolboxes, as the SBTOOLBOX2 might become unstable if the data scale is increased.

The models in the models base directory are compatible with both Octave and Matlab.

### Requirements for Octave-based models

* Octave environment (tested with 3.6.2)
* Optim package (http://octave.sourceforge.net/optim/)

### Requirements for Matlab-based models

* Matlab environment
* Optimization toolbox
* Compiler toolbox

### Requirements for SBTOOLBOX2-based models

* Matlab environment
* Compiler toolbox
* SBTOOLBOX2 toolbox
* SBPD toolbox

## Structure

The usage of any model is dependant of having three files:
* model: where the model's equation is defined
* estimator : .m file that defines the necessary steps to estimate parameters
* simulator : .m file that simulates a curve with given parameters

These files allow to generate a cgi script for the model that can be accessed online or in a local computer

## Create a new model blackbox

### Octave / Matlab model

1. Clone the repository

1. Navigate to the models folder

1. Navigate to the algebraic or differential folder, depending on the model type. If it is defined as an algebraic equation or as an differential, choose the right folder

1. Copy the TEMPLATE folder and name it to the model name

1. Open each of the .m files and change it accordingly
* model: write the equation, if it is a differential equation don't forget the initial condition
* estimator: change the 'model' variable to the name of the model
* simulator: change how the params are set in alphabetical order and the 'model' variable

#### for octave:

navigate to the base dir and run
<pre>make octave</pre>

#### for matlab:

navigate to the base dir
add to the Makefile file a target using any of the existing as a template
<pre>make %model_name%</pre>

### SBTOOLBOX2 model

1. create a SBTOOLBOX2 model (SBModel) and copy it the directory:
<pre> source/models/</pre>
1. compile the model calling the compile_model.m function, ex:
<pre> compile_model('models/baranyi')</pre>
1. copy the following files to the same directory and name it after the model, preserving the suffix (just to help organizing the files' function
<pre> source/estimators/TEMPLATE_est.m
 source/simulators/TEMPLATE_sim.m</pre>
1. change the source code to reflect the name of the model by replacing all the occurences of Gompertz to "Yourmodel"
<pre> IMPORTANT: the first letter must be Uppercase</pre>
1. in the simulators/Yourmodel_sim.m you must change the code to handle the model's parameters
1. add the makefile target following the existing templates
1. run
 <pre>make yourmodel_est yourmodel_sim clean</pre>

## Test the model

You can simulate the query by calling in Octave/Matlab the respective function with the arguments:
* simulate flag: if 1 then it will use te test data defined at the top of the function
* draw plot: draws a plot of the results

## Deploy

These functions can be deployed as cgi scripts throught a REST API and return a json response. The parameters can be passed in the url or as POST.

### Octave

The cgi scripts must be accessible from the web server and this toolbox must be in the path (defined in the query when generated)

### Matlab or SBTOOLBOX2

The makefile will generate a standalone that only needs the Matlab libraries to run.
