library(dplyr)
library(tidyverse)
library(tidyr)
library(broom)
library(readxl)
library(regclass)
library(plyr)

df = read_excel("linearmodel.xlsx",na = "-99")

#Set categorical variables
df$Sex <- as.factor(df$Sex)
df$Hist_any_six <- as.factor(df$Hist_any_six)
df$LPA_profile <- as.factor(df$LPA_profile)


#Model 1 Multivariate in 3 steps
mod1_1_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex, data = df, weights= Weight)
mod1_2_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex + Hist_any_six, data = df, weights= Weight)
mod1_3_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex + Hist_any_six + scale(PHQ9) + scale(GAD7) + scale(PCL5) + scale(PHQ15) + scale(SCI) + scale(CFQ), data = df, weights= Weight)
#Standardised betas 
mod1_3_coefs_scaled <- tidy(mod1_3_scaled)
#VIFs
mod1_3_vif_scaled <- tidy(VIF(mod1_3_scaled))
#2 ANOVAs comparing addition of groups of factors (Model building in Supplementary Table S8)
mod1_building_scaled <- tidy(anova(mod1_1_scaled, mod1_2_scaled, mod1_3_scaled))
#Model performance summary statistics
mod1_evaluation_scaled <-glance(mod1_3_scaled)%>%
  dplyr::select(r.squared, adj.r.squared, statistic, df, df.residual, p.value)

#Model 2 Multivariate in 3 steps
mod2_1_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex, data = df, weights= Weight)
mod2_2_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex + Hist_any_six, data = df, weights= Weight)
mod2_3_scaled <- lm(scale(WHODAS) ~ scale(Age) + Sex + Hist_any_six + LPA_profile, data = df, weights= Weight)
#Standardised betas
mod2_3_coefs_scaled <- tidy(mod2_3_scaled)
#VIF
mod2_3_vif_scaled <- tidy(VIF(mod2_3_scaled))
#2 ANOVAs comparing addition of groups of factors (Model building in Supplementary Table S8)
mod2_building_scaled <- tidy(anova(mod2_1_scaled, mod2_2_scaled, mod2_3_scaled))
#Model performance summary statistics
mod2_evaluation_scaled <-glance(mod2_3_scaled)%>%
  dplyr::select(r.squared, adj.r.squared, statistic, df, df.residual, p.value)

#Getting univariate standardised betas for Model 1
mod1_uni_age_scaled <- tidy(lm(scale(WHODAS)~ scale(Age), data=df, weights = Weight))
mod1_uni_sex_scaled <- tidy(lm(scale(WHODAS)~ Sex, data=df, weights = Weight))
mod1_uni_his_scaled <- tidy(lm(scale(WHODAS)~ Hist_any_six, data=df, weights = Weight))
mod1_uni_phq9_scaled <- tidy(lm(scale(WHODAS)~ scale(PHQ9), data=df, weights = Weight))
mod1_uni_gad_scaled <- tidy(lm(scale(WHODAS)~ scale(GAD7), data=df, weights = Weight))
mod1_uni_pcl_scaled <- tidy(lm(scale(WHODAS)~ scale(PCL5), data=df, weights = Weight))
mod1_uni_phq15_scaled <- tidy(lm(scale(WHODAS)~ scale(PHQ15), data=df, weights = Weight))
mod1_uni_sci_scaled <- tidy(lm(scale(WHODAS)~ scale(SCI), data=df, weights = Weight))
mod1_uni_cfq_scaled <- tidy(lm(scale(WHODAS)~ scale(CFQ), data=df, weights = Weight))
mod1_uni_dfs_scaled <- list(mod1_uni_age_scaled, mod1_uni_sex_scaled, mod1_uni_his_scaled, mod1_uni_phq9_scaled, mod1_uni_gad_scaled, mod1_uni_pcl_scaled, mod1_uni_phq15_scaled, mod1_uni_sci_scaled, mod1_uni_cfq_scaled)
mod1_uni_dfjoin_scaled <- join_all(mod1_uni_dfs_scaled, by = NULL, type = "full", match = "all")

#Getting univariate standardised betas for Model 2
mod2_uni_lpa_scaled <- lm(scale(WHODAS)~ LPA_profile, data=df, weights = Weight)
