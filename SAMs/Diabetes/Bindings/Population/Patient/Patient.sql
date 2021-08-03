/*
*BindingNM:Patient
*EntityNM:PopulationPatient
*Description:Distinct List of all Patients along with their first Cohort qualification date
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated column names
	
*******************************************************************************/
SELECT DISTINCT
    PatientID
	, MIN(QualifyDTS) OVER (PARTITION BY PatientID) AS FirstQualifyDTS
FROM SAM.Training.HCUDiabetesRuleBASE