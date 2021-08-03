/*
*BindingNM:Diagnosed (Pre)Diabetic
*EntityNM:DiabetesRule
*Description: Pulls Diabetes & Pre-Diabetes Diagnoses Events into Rule Table
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
	,e.PatientEncounterID
	,e.MRN
	,e.EventID AS RuleID	/*New RuleID can be hardcoded as necessary/desired*/
	,e.EventNM AS RuleNM	/*New RuleNM can be hardcoded as necessary/desired*/
	,e.DiagnosisDTS as TriggerDTS
	,e.DiagnosisDTS as QualifyDTS
FROM SAM.Training.HCUDiabetesEventDiagnosisBASE e
WHERE E.EventID IN (1,2)