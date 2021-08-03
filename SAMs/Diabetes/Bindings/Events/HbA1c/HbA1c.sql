/*
*BindingNM:HbA1C
*EntityNM:DiabetesEventHbA1C
*Description:Captures HbA1c scores
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
1	11 Dec 2020		Matt U			Updated column names
	
*******************************************************************************/
SELECT 
	 res.PatientID
	,res.PatientEncounterID
	,pat.MRN
	,3 AS EventID
	,'HbA1c Result' AS EventNM
	,res.OrderID
	,com.ComponentCD
	,com.ComponentNM
	,res.ResultValueNBR
	,res.OrderDTS
	,res.ResultDTS
FROM SAMDemo.Orders.ResultBASE res
	INNER JOIN SAMDemo.Reference.ComponentBASE com
		ON com.ComponentCD = res.ComponentCD
	INNER JOIN SAMDemo.Patient.PatientBASE pat
		ON pat.PatientID = res.PatientID
WHERE res.ComponentCD='C001'
