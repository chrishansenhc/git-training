/*
*BindingNM:PM Social History
*EntityNM:DiabetesPreMetricSocialHistory
*Description:Gathers information around Tobacco use for Diabetic Patients
*Author: Matt U
*Date: 27 Aug 2018
*******************************************************************************
**Change History
*******************************************************************************
PR	Date			Author			Description
*******************************************************************************/
SELECT
	 pop.PatientID
	,sh.SocialHistoryDTS
	,sh.TobaccoUseDSC
FROM SAM.Training.HCUDiabetesPopulationPatientBASE pop
	INNER JOIN SAMDEMO.Patient.SocialHistoryBASE sh
		ON sh.PatientID = pop.PatientID
		
/*
Note: The source table could simply have been used to join in the Summary Metric to show Tobacco usage as an attribute. The reason it is created as a PreMetric is in this use case, it is used to set a Flag (metric) around tobacco compliance
*/