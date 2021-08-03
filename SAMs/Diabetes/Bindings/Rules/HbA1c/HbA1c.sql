/*
*BindingNM:HbA1c
*EntityNM:DiabetesRule
*Description: Determines condition (Diabetes/Pre-Diabetes) based on HbA1c Score
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated column names
	
*******************************************************************************/
SELECT
    e.PatientID
	, e.PatientEncounterID
	, e.MRN
	, CASE WHEN e.ResultValueNBR >= '6.5' THEN 3 ELSE 4 END AS RuleID
	, CASE WHEN e.ResultValueNBR >='6.5' THEN 'HbA1C Diabetic' ELSE 'HbA1C PreDiabetic' END AS RuleNM
	, e.ResultDTS as TriggerDTS
	, e.ResultDTS as QualifyDTS
FROM SAM.Training.HCUDiabetesEventHbA1CBASE e
WHERE e.EventID = 3
    AND ResultValueNBR >= 5.7