*(I) Establishing the IHS-transformed functional form ihs_num_tot of outcome variable num_tot
*a) num_tot
histogram num_tot, frequency 
    title("Distribution of Total Birds Counted") 
    xtitle("Total Bird Count") 
    ytitle("Frequency")
*b) num_tot	
histogram ihs_num_tot, frequency 
    title("Distribution of Total Birds Counted- IHS Transformation") 
    xtitle("Total Bird Count- IHS Transformation") 
    ytitle("Frequency")

*As mentioned in the essay, I use IHS-transformed variables based on the functional form they take over linear dependent variables.
	
*(II) Running the Difference-in-Differences (DID) Model

*a) Declare panel data structure:
xtset circle_id year  

*b) Using Fixed Effects regression to control for circle-specific and year-specific effects:

*i) ihs_num_tot and any_shale
xtreg ihs_num_tot any_shale ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

*Installing the outreg2 package to create regression tables on a Word document:
ssc install outreg2, replace

outreg2 using regressions.doc, replace 

*ii) ihs_num_tot and any_turbine
xtreg ihs_num_tot any_turbine ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using regressions.doc, replace 

*iii) ihs_num_species and any_turbine
xtreg ihs_num_species any_turbine ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using regressions.doc, replace 

*iv) ihs_num_species and any_shale
xtreg ihs_num_species any_shale ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using regressions.doc, replace 

*(III) Robustness Checks

*1) Placebo Test: Generating lead_any_shale as a functoin of any_shale and using it as the treatment. 
gen lead_any_shale = F.any_shale

xtreg ihs_num_tot lead_any_shale ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using results.doc, replace 

*2) Alternative Specifications of the Treatment Variable (binary vs linear): ihs_num_tot and shalewells_num
xtreg ihs_num_tot shalewells_num ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using regressions.doc, replace

*3) Alternative Functional Form (IHS specification):  num_tot and any_shale
xtreg num_tot any_shale ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)

outreg2 using regressions.doc, replace 

*(IV) Confounder Test: Human Population (lnpop) as an additional control
xtreg ihs_num_tot lnpop any_shale ihs_total_effort_counters Min_temp Max_temp Max_wind Max_snow Min_snow latitude longitude ag_land_share past_land_share dev_share_broad i.year, fe vce(cluster circle_id)
outreg2 using regressions.doc, replace
