/*
*BindingNM:M Patient
*EntityNM:DiabetesMetricPatient
*Description:Calculates various metrics for each diabetic patient
*Author: Matt U
*Date: 27 Aug 2018
*************************************************************************************************
**Change History
*************************************************************************************************
PR	Date			Author			Description
1	30 Dec 2020		Matt U			Removed CTEs after ROW_NUMBER added to PreMetrics
	
*************************************************************************************************/
SELECT
	 pop.PatientID
	,pat.BirthDTS
	,DATEDIFF(year,pat.BirthDTS,pop.FirstQualifyDTS) AS PatientAgeAtDiagnosisNBR
	,DATEDIFF(year,pat.BirthDTS,getdate()) AS PatientCurrentAgeNBR
	
	/*Blood Pressure Metrics*/
	,v.PatientEncounterID AS LastBloodPressureEncounterID
	,v.EncounterDTS AS LastBloodPressureDTS
	,v.SystolicNBR LastBloodPressureSystolicNBR
	,v.DiastolicNBR AS LastBloodPressureDiastolicNBR
	,DATEDIFF(DAY,v.EncounterDTS,getdate()) AS DaysSinceLastBloodPressureCNT
	,CASE WHEN v.DiastolicNBR < 90 AND v.SystolicNBR < 140 THEN 1 ELSE 0 END AS BloodPressureControlledFLG
	
	/*HbA1c Metrics*/
	,a1c.PatientEncounterID AS LastHbA1CEncounterID
	,a1c.ResultDTS AS LastHbA1cDTS
	,DATEDIFF(DAY,a1c.ResultDTS,getdate()) AS DaysSinceHbA1cCNT
	,a1c.ResultValueNBR AS LastHbA1cResultNBR
	,CASE WHEN a1c.ResultValueNBR  < 8 THEN 1 ELSE 0 END AS HbA1cControlledFLG
	,CASE WHEN DATEDIFF(DAY,a1c.ResultDTS,getdate()) <=90 THEN 1 ELSE 0 END AS HbA1cResultCurrentFLG
	
	/*Cholesterol (LDL) Metrics*/
	,ldl.PatientEncounterID AS LastLDLEncounterID
	,ldl.ResultDTS AS LastLDLDTS
	,DATEDIFF(Day,ldl.ResultDTS, getdate()) AS DaysSinceLDLCNT
	,ldl.ResultValueNBR AS LastLDLResultNBR
	,CASE WHEN ldl.ResultValueNBR < 100 THEN 1 ELSE 0 END AS LDLControlledFLG
	
	/*Tobacco Usage*/
	,CASE WHEN sh.TobaccoUseDSC IN ('QUIT','NEVER') THEN 1 ELSE 0 END AS TobaccoCompliantFLG

FROM SAM.Training.HCUDiabetesPopulationPatient pop
	INNER JOIN SAMDEMO.Patient.PatientBASE pat
		ON pop.PatientID = pat.PatientID
	LEFT OUTER JOIN SAM.Training.HCUDiabetesPreMetricVitalsBASE v
		ON v.PatientID = pop.PatientID
			AND v.BloodPressureOrderNBR = 1
	LEFT OUTER JOIN SAM.Training.HCUDiabetesPreMetricLabBASE a1c
		ON a1c.PatientID = pop.PatientID
			AND a1c.ComponentOrderNBR = 1
			AND a1c.ComponentCD = 'C001'
	LEFT OUTER JOIN SAM.Training.HCUDiabetesPreMetricLabBASE ldl
		ON ldl.PatientID = pop.PatientID
			AND a1c.ComponentOrderNBR = 1
			AND a1c.ComponentCD = 'C002'
	LEFT OUTER JOIN SAM.Training.HCUDiabetesPreMetricSocialHistoryBASE sh
		ON sh.PatientID = pop.PatientID