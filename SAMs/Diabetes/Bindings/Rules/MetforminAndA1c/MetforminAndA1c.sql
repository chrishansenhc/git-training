/*
*BindingNM:Metformin and A1C
*EntityNM:DiabetesRule
*Description:Includes patient in registry if a HbA1c Lab Result is accompanied a Medication Order for Metformin within 30 days*
		*For training purposes. Actual rule used during clinical implentation may have varied
		*Note the typo for RuleNM alias. Included to throw error in SAMD for training purposes
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated column names
	
*******************************************************************************/
SELECT
    a.PatientID
	, m.PatientEncounterID
	, a.MRN
	, 5 AS RuleID
	, 'Metformin + HbA1c' AS RuleMN
	, m.MedicationOrderDTS AS TriggerDTS
	, a.OrderDTS AS QualifyDTS
FROM SAM.Training.HCUDiabetesEventHbA1CBASE a
    INNER JOIN SAM.Training.HCUDiabetesEventMedication m
    ON m.PatientID = a.PatientID
WHERE (a.EventID = 3 AND m.EventID = 4)
    --AND m.MedicationOrderDTS <= a.ResultDTS --Medication prescribed at or before A1c
    AND DATEDIFF(DAY,MedicationOrderDTS,ResultDTS) BETWEEN -30 AND 30