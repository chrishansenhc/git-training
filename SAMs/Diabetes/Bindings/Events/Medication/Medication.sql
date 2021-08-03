/*
*BindingNM:Medication
*EntityNM:DiabetesEventMedication
*Description:Captures Medication (Metformin) orders
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated column names
	
*******************************************************************************/
SELECT
	 om.PatientID
	,om.PatientEncounterID
	,pat.MRN
	,4 AS EventID
	,'Medication Orders' AS EventNM
	,om.MedicationID
	,med.MedicationNM
	,om.DosageMGAMT + ' mg' AS DosageAMT
	,om.MedicationOrderDTS 
FROM SAMDemo.Orders.MedicationBASE om
	INNER JOIN SAMDemo.Reference.MedicationBASE med
		ON med.MedicationID = om.MedicationID
	LEFT OUTER JOIN SAMDemo.Patient.PatientBASE pat
		ON pat.PatientID = om.PatientID
WHERE om.MedicationID IN            
				('MED0001'
				,'MED0002'
				,'MED0003'
				,'MED0004')
