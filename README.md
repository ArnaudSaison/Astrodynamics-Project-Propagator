# Astrodynamics-Project-Propagator

```
 ______                                 .-._   _ _ _ _ _ _ _ _
 | ___ \                     .-''-.__.-'00  '-' ' ' ' ' ' ' ' '-.
 | |_/ / __ ___  _ __   __ _ '.___ '    .   .--_'-' '-' '-' _'-' '._
 |  __/ '__/ _ \| '_ \ / _` | V: V 'vv-'   '_   '.       .'  _..' '.'.
 | |  | | | (_) | |_) | (_| |   '=.____.=_.--'   :_.__.__:_   '.   : :
 \_|  |_|  \___/| .__/ \__,_|           (((____.-'        '-.  /   : :
                | |                                       (((-'\ .' /
                |_|                                     _____..'  .'
                                                       '-._____.-'

```

>The objective of this project is the development of an orbital propagator in the Matlab environment. This propagator should provide a realistic approxi- mation of spacecraft trajectories around the Earth. Eventually, the predictions of your propagator should be compared against the real trajectory of a satellite in low Earth orbit.

**Authors**: Antoine Montuzet, Arnaud Saison \
**Academic year**: 2022-2023 \
**Course**: AERO0024-1 Astrodynamics

(Credits: ASCII Art by Shanaka Dias from https://www.asciiart.eu/animals/reptiles/alligators)

# User Guide
## System requirements
- MATLAB R2022a or later
- Aerospace Toolbox
- Warning: some of the codes can take up to several minutes to run.

Others:
- The S3L propagator is required to be placed in a folder named `S3Lprop_v1_21`.
- The SGP4 analytical propagator as provided by S3L must be placed that same folder.
- The file structure should not be changed

## Project
Each question of the project is answered in a separate file:
- `Propagator01_Saison_Montuzet.m` = simple two-body problem for ISS orbit for 24 hours
- `Propagator02_Saison_Montuzet.m` = two-body with J2 perturbation for ISS orbit for 24 hours
- `Propagator03_Saison_Montuzet.m` = two-body with J2 and drag for ISS orbit for 24 hours
- `Propagator04_Saison_Montuzet.m` = two-body with J2 and drag for HST orbit for 24 hours, and SGP4 abalytical propagator

Each file has a corresponding paramters file with the same number identifier.

## Propagator
The propagator requires a parameters structure as generated by `processParam.m`, which requires itself an input paramters structure. No processing should be done before using `processParam.m`. The parameters file must contain:
- Options for perturbations
    - `par.ENABLE_J2` = {1,0} enables/disables J2 perturbation
    - `par.ENABLE_DRAG` =  {1,0} enables/disables drag perturbation using Harris-Priester
- TLE has 2 different modes, both work with only one object to propagate:
    - Give one TLE (three line element) that is used as initial orbit for propgation.
        - `par.TLE.L0` = line 0 the TLE
        - `par.TLE.L1` = line 1 the TLE
        - `par.TLE.L2` = line 2 the TLE
    - Give TLEs in bulk for same object. Initial TLE is used for propagation, followings are plotted for comparison. There should be a `txt` file containing all TLEs (three line elements). 
        - `par.BULKTLES_FILENAME` = \[char vector (uses '', NOT ""), whitout extension name\] file containing all TLEs without additional lines at the end, exactly as download from Space-Track.org
- In order to use SGP4, an additional, specially formatted TLE (two line element in this case) is required. 
    - `par.SGP4TLE_FILENAME` = \[char vector (uses '', NOT ""), whitout extension name\] file containing one TLE
    - `par.SGP4_ECI_MODE` = {1,0} enables/diables use of `tle2eci.m` file that is provided by S3L and does not work properly. Can be used for comparison, but orbit will be incorrect.
- Drag parameters
    - `par.prop.MASS` = \[kg\] mass of object
    - `par.prop.CD` = \[-\] drag coefficient of the object
    - `par.prop.A` = \[m^2\] object area
    - `par.prop.n` = Harris-Priester value for inclination of orbit
- Solver parameters
    - `par.SOLVER` = {ODE45, ODE78, ODE113} solver used for propagation
    - `par.N_STEP` = \[nb\] number of step in the simulation
    - `par.T_END` = \[s\] number of seconds in the simulation
    - `par.REL_TOL` = \[-\] relative tolerance
    - `par.ABS_TOL` = \[-\] absolute tolerance
- `par.DEBUG` = {1,0} enable/diasable additional command window outputs
- Print to PDF feature
    - `par.PRINT_PDF` = {1,0} enable/disable printing figures to PDF in the specified figures folder (WARNING: printing figures to PDF requires about 1 second per figure)
    - `par.PDF_FOLDER` = \[char vector (uses '', NOT "")\] folder in which PDF figures are saved

# Project strucure and functionalities
Structure:
  - `data/`
      - `bulkISSTLEs.txt`         several ISS TLEs
      - `ISSTLE.txt`              TLE (two lines) of the ISS for SGP4
      - `ISSTLE.txt`              HST (two lines) of the HST for SGP4 
      - `coast.mat`               coast outlines
      - `planetaryData.m`         all astronomical data (R_earth, mu, J2, ...)
  - `figures/`                    contains all output figures (folder name can be changed in parameters file)
  - `propagator/`
      - `matlab/`
          - `anaDragPertu.m`      analytical formulas for drag
          - `anaNoPertu.m`        analytical formulas without perturbations
          - `anaOblPertu.m`       analytical formulas for J2
          - `diffEq.m`            differential equation
          - `ECI2ECEF2LLA2OE.m`   all frame transformations
          - `ECI2kepl.m`          calls ijk2keplerian for all time steps
          - `getLatestTLE.m`      uses Celestrack API to get latest TLE of object
          - `harris_priester.m`   calculates the density depending on position and altitude
          - `mean2trueAnomaly.m`  converts mean anomaly to true anomaly
          - `processBulkTLEs.m`   processes several TLEs in txt file
          - `processParam.m`      processes and groups parameters and TLE
          - `processTLE.m`        parses and converts text TLE to orbital elements, utc time, and orbital elements
          - `propagator.m`        solves the equation of motion with solvers
      - `python/`
    - `S3Lprop_v1_21/`            contains all S3L propagator files WARNING: FOLDER MUST BE PLACED THERE AND HAVE THIS PRECISE NAME
        - `tle2eci/tle2eci.p-m`   m and p file for tle2eci provided by S3L
  - `utils/`
      - `angleDiscon.m`           allows representation between 0 and 360° without cutting plot on screen
      - `betterYLim.m`            centers data and limits to bounds
      - `dispKeplerian.m`         displays keplerian elements in command window
      - `dispLine.m`              diplays a horizontal line in the command window
      - `dispParam.m`             displays parameters as output by processParam in the command window
      - `errorComparison.m`       plots ECI and LLA errors
      - `fig2pdf.m`               automatically converts figure to pdf
      - `grdtrk.m`                customized ground track function as provided in project statement
      - `plot_3D.m`               represents solution in 3D
      - `plotConstant.m`          detects if data for a plot is almost cst
      - `plotDayLines.m`          plots vertical line at each day
      - `plotOE.m`                plots all the orbital elements
      - `plotOrbit.m`             plots ground track and altitude
      - `xticksCustomDate.m`      plots hours on minor grid
 - `convergenceStudy.m`           convergence study script
 - `Propagator01_Saison_Montuzet.m`
 - `Propagator02_Saison_Montuzet.m`
 - `Propagator03_Saison_Montuzet.m`
 - `Propagator04_Saison_Montuzet.m`
 - `uncertaintyStudy`             visualization of uncertainty on $\mu$
