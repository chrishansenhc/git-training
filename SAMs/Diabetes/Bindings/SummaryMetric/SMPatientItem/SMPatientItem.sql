/*
*BindingNM:SM Patient Item
*EntityNM:DiabetesSummaryMetricPatientItem
*Description:Pulls in last 5 measures of key labs/vitals for use in visualization. Non-persisted to avoid unnecessary storage duplication
*Author: Matt U
*Date: 27 Aug 2018
*********************************************************************************************************************************************
**Change History
*********************************************************************************************************************************************
PR	Date			Author			Description
	
*********************************************************************************************************************************************/
SELECT
	 v.PatientID
	,1 AS MeasurementCD
	,'Blood Pressure' AS MeasurementNM
	,CONCAT(v.SystolicNBR ,'/',v.DiastolicNBR) AS MeasurementVAL
	,v.EncounterDTS AS MeasurementDTS
FROM SAM.Training.HCUDiabetesPreMetricVitals v
WHERE v.BloodPressureOrderNBR <= 5


UNION

SELECT
	 a1c.PatientID
	,2 AS MeasurementCD
	,a1c.ComponentNM AS MeasurementNM
	,CAST(a1c.ResultValueNBR AS Varchar(50)) AS MeasurementVAL
	,a1c.ResultDTS AS MeasurementDTS
FROM SAM.Training.HCUDiabetesPreMetricLab a1c
WHERE 1=1
	AND a1c.ComponentCD = 'C001'
	AND a1c.ComponentOrderNBR <=5

UNION

SELECT
	 ldl.PatientID
	,3 AS MeasurementCD
	,ldl.ComponentNM AS MeasurementNM
	,CAST(ldl.ResultValueNBR AS Varchar(50)) AS MeasurementVAL
	,ldl.ResultDTS AS MeasurementDTS
FROM SAM.Training.HCUDiabetesPreMetricLab ldl
WHERE 1=1
	AND ldl.ComponentCD = 'C002'
	AND ldl.ComponentOrderNBR <=5
;