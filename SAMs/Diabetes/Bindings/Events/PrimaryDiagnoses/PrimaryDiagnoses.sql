/*
*BindingNM:Primary Diagnoses
*EntityNM:DiabetesEventDiagnosis
*Description:Captures diagnoses for Diabetes & PreDiabetes
*Author: Matt Unwin
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated ICD10 values
	
*******************************************************************************/
SELECT
	 pe.PatientID
	,pe.PatientEncounterID
	,pat.MRN
	,CASE
		WHEN DiagnosisID = 'Dx005' THEN 2
		ELSE 1 END AS EventID
	,CASE
		WHEN DiagnosisID = 'Dx005' THEN 'Primary Diagnosis - PreDiabetes'
		ELSE 'Primary Diagnosis - Diabetes' END AS EventNM
	,pe.PrimaryDiagnosisID
 	,dx.DiagnosisNM
	,dx.ICD10
	,pe.EncounterDTS AS DiagnosisDTS
FROM SAMDemo.Encounter.PatientEncounterBASE pe
	INNER JOIN SAMDemo.Patient.PatientBASE pat
				ON pe.PatientID = PAT.PatientID
	INNER JOIN SAMDemo.Reference.DiagnosisBASE dx
				ON dx.DiagnosisID = pe.PrimaryDiagnosisID
WHERE dx.DiagnosisID IN
				('Dx001'
				,'Dx002'
				,'Dx003'
				,'Dx004'
				,'Dx005'
				)
;