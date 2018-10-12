rm(list=ls())

library("Hmisc"); library(ROCR); library("geepack");library(xlsx)
data    = readRDS("D:/Dropbox/HMRF_Health seeking behaviour/R/Data_rds/20180326_data.rds")
df_dl   = readRDS("D:/Dropbox/HMRF_Health seeking behaviour/R/Data_rds/20180326_df_dl.rds")
df_sick = readRDS("D:/Dropbox/HMRF_Health seeking behaviour/R/Data_rds/20180326_df_sick.rds")
symdrome_name = readRDS("D:/Dropbox/HMRF_Health seeking behaviour/R/Data_rds/symdrome_name.rds")
symdrome_name_grouped = readRDS("D:/Dropbox/HMRF_Health seeking behaviour/R/Data_rds/symdrome_name_grouped.rds")
stand=read.csv("D:/Dropbox/HMRF_Health seeking behaviour/R/Data/Population by Sex and Age 2014.csv")
stand$Pct=stand[,3]/sum(stand[,3])
stand
m=100
n=2000


setwd("D:/Dropbox/HMRF_Health seeking behaviour/R/Project 1 Trigger exploration")
abc_0_15 = readRDS("Output rds/abc_0_15.rds")
abc_16_54 = readRDS("Output rds/abc_16_54.rds")
abc_55up = readRDS("Output rds/abc_55up.rds")
abc_list = readRDS("Output rds/abc_list.rds")

setwd("D:/Dropbox/HMRF_Health seeking behaviour/R/Project 2 Preventive measures")

col_newSS4_1 = which(names(abc_0_15[[1]])=="newSS4_1") #24
col_HS2B_1 = which( names(abc_0_15[[1]])=="HS2B_1") 
col_HS2B_1_imp = which( names(abc_0_15[[1]])=="HS2B_1_imp") 
col_HS_imp = which( names(abc_0_15[[1]])=="HS_imp") # 101
col_HS = which( names(abc_0_15[[1]])=="HS") # 67
col_ILI = which(names(abc_0_15[[1]])=="ILI")
col_ARI = which(names(abc_0_15[[1]])=="ARI")
col_anyTrigger_ILI = which(names(abc_0_15[[1]])=="anyTrigger_ILI")
col_anyTrigger_ARI = which(names(abc_0_15[[1]])=="anyTrigger_ARI")
col_anyTrigger_ILI_imp = which(names(abc_0_15[[1]])=="anyTrigger_ILI_imp")
col_anyTrigger_ARI_imp = which(names(abc_0_15[[1]])=="anyTrigger_ARI_imp")
