/*
*BindingNM:PM Vitals
*EntityNM:DiabetesPreMetricVitals
*Description:Gathers Blood Pressure results for Diabetic Patients
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	30 Dec 2020		Matt U			Added Row_Number to simplify metric query
	
*******************************************************************************/
SELECT
	 pop.PatientID
	,enc.PatientEncounterID
	,enc.SystolicNBR
	,enc.DiastolicNBR
	,enc.EncounterDTS
	,ROW_NUMBER() OVER (PARTITION BY enc.PatientID ORDER BY enc.EncounterDTS DESC) AS BloodPressureOrderNBR
FROM SAM.Training.HCUDiabetesPopulationPatientBASE pop
	INNER JOIN SAMDEMO.Encounter.PatientEncounterBASE enc
		ON enc.PatientID = pop.PatientID
WHERE SystolicNBR IS NOT NULL 
	AND DiastolicNBR IS NOT NULL
