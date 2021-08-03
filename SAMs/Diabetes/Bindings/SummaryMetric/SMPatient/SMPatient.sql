/*
*BindingNM:SM Patient
*EntityNM:DiabetesSummaryMetricPatient
*Description:Pulls in Patient Level Metrics along with desired attributes
*Author: Matt U
*Date: 27 Aug 2018
*************************************************************************************************
**Change History
*************************************************************************************************
PR	Date			Author			Description
	
*************************************************************************************************/
SELECT
	 pop.PatientID
	,pat.PatientFullNM
	,pat.GenderCD
	,pat.BirthDTS
	,m.PatientAgeAtDiagnosisNBR
	,m.PatientCurrentAgeNBR
	,pat.DeathDTS
	,CASE WHEN pat.DeathDTS IS NULL THEN 0 ELSE 1 END AS PatientDeceasedFLG
	,pat.RaceDSC
	,pat.ReligionDSC
	,pat.LanguageDSC
	,pat.CurrentPCPID
	,prv.ProviderFullNM AS CurrentPCPProviderNM
	,prv.PrimarySpecialtyNM AS CurrentPCPProviderSpecialtyDSC
	,pat.PrimaryPayorID
	,pay.PayorNM AS PrimaryPayorNM
	,m.LastBloodPressureEncounterID
	,m.LastBloodPressureDTS
	,m.LastBloodPressureDiastolicNBR
	,m.LastBloodPressureSystolicNBR
	,m.DaysSinceLastBloodPressureCNT
	,m.BloodPressureControlledFLG
	,m.LastHbA1CEncounterID
	,m.LastHbA1cDTS
	,m.DaysSinceHbA1cCNT
	,m.LastHbA1cResultNBR
	,m.HbA1cControlledFLG
	,m.HbA1cResultCurrentFLG
	,m.LastLDLEncounterID
	,m.LastLDLDTS
	,m.DaysSinceLDLCNT
	,m.LastLDLResultNBR
	,m.LDLControlledFLG
FROM SAM.Training.HCUDiabetesPopulationPatient pop
	INNER JOIN SAMDEMO.Patient.PatientBASE pat
		ON pat.PatientID = pop.PatientID
	LEFT OUTER JOIN SAM.Training.HCUDiabetesMetricPatient m
		ON m.PatientID = pop.PatientID
	LEFT OUTER JOIN SAMDEMO.Reference.PayorBASE pay
		ON pay.PayorID = pat.PrimaryPayorID
	LEFT OUTER JOIN SAMDEMO.Reference.ProviderBASE prv
		ON prv.ProviderID = pat.CurrentPCPID
