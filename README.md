# CU-COVID19-DXLPA

This repository contains R and Python scripts for analyzing COVID-19 patient data as part of the World Mental Health CU-COVID19 study. The analysis focuses on the dimensional structure of one-year post-COVID-19 neuropsychiatric and somatic sequelae and their association with role impairment.

## Data

The dataset consists of 248 COVID-19 patients in Hong Kong.

## Analysis

1. **Latent Profile Analysis (LPA)**: Performed using MCLUST on R, clustering patients into 4 classes based on cognitive impairment, fatigue, and neuropsychiatric symptom scores (PHQ9, GAD7, PCL5, PHQ15, AMIC, and CFQ11).

2. **Linear Models**: Two linear models were created using LM() in R to predict WHODAS impairment.
   - Model 1 predictors: demographic variables, history of mental disorder, and average symptom scores.
   - Model 2 predictors: latent profiles.

3. **Machine Learning Classifiers**: Logistic regression and random forest models were built using sklearn in Python to differentiate profile pairs based on 51 unweighted individual symptom scores.

4. **SHAP**: The SHAP (Python SHAP v0.4) interpretation algorithm was applied to the most accurate model to assess symptom importance in the machine learning classifiers.

## Files

- `mclust.R`: R script for running Latent Profile Analysis using MCLUST.
- `linearmodel.R`: R script for running linear models using LM().
- `SHAP.ipynb`: Jupyter Notebook containing Python code for creating logistic regression and random forest models and using SHAP to identify variable importance.
