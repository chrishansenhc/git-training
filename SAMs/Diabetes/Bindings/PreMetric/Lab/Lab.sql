/*
*BindingNM:PM Labs
*EntityNM:DiabetesPreMetricLab
*Description:Gathers Lab results (LDL & HbA1c) for Diabetic Patients
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	30 Dec 2020		Matt U			Added Row_Number to simply metric query
	
*******************************************************************************/
SELECT
	 pop.PatientID
	,r.PatientEncounterID
	,r.OrderDTS
	,r.ResultDTS
	,r.ComponentCD
	,c.ComponentNM
	,r.ResultValueNBR
	,ROW_NUMBER() OVER (PARTITION BY pop.PatientID, r.componentCD ORDER BY r.resultDTS DESC) AS ComponentOrderNBR
FROM SAM.Training.HCUDiabetesPopulationPatientBASE pop
	INNER JOIN SAMDEMO.Orders.ResultBASE r
		ON r.PatientID = pop.PatientID
	INNER JOIN SAMDEMO.Reference.ComponentBASE c
		ON c.ComponentCD = r.ComponentCD
WHERE c.ComponentCD IN ('C001','C002')