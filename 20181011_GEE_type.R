setwd("D:/Dropbox/HMRF_Health seeking behaviour/R/Project 2 Preventive measures")
source("R script/20181010_final read.r")
# data_gee = abc_list[[1]]
# outcome = "HS1_C1_A"
fun_gee = function(data_gee, outcome){
  # identify the variable names  
  symp_var = paste(names(data_gee)[c(col_newSS4_1:(col_newSS4_1+22),col_ILI,col_ARI)],  collapse='+')
  demographic_var = "SG1 + factor(agegp) + factor(incomegp) + SS6 + SS7 + round + factor(MC1)"
  # Outcome, predictor, formula  
  outcome = outcome 
  predictor = paste(symp_var, demographic_var, sep = "+")
  geeformula = as.formula(paste(outcome, predictor, sep="~"))
  # make "round" a factor  
  data_gee$round = relevel(factor(data_gee$round), ref=2)
  # run GEE  
  geemodel = geeglm( geeformula, data_gee, id = data_gee[,"ID"], family = binomial, corstr = "exchangeable", weights=poststra)
  # format CI and result table  
  LL= exp(coef(geemodel)-qnorm(.975) *summary(geemodel)$coef[,2]);LL= round(LL,1)
  UL= exp(coef(geemodel)+qnorm(.975) *summary(geemodel)$coef[,2]);UL= round(UL,1)
  p = round( summary(geemodel)$coef[,4] ,2)
  p = format( p, nsmall = 2)
  options(scipen=999)
  OR = round(exp(coef(geemodel)),1)
  CI = paste0("(", format(LL,nsmall=1),", ",format(UL,nsmall=1),")")
  sig = ifelse(p < 0.05, "*", " ")
  result=cbind( OR, CI, p, sig)
  rownames(result) = c("(Intercept)", symdrome_name_grouped, "ILI","ARI",
                     "Male","0-15 yr","55+ yr","below 20k","40k+",
                     "Refuse to answer", "Chronic disease", "Medication",
                     "Round 1","Round 3","Round 4",
                     "Insurance_employer","Insurance_self","Insurance_both")
  # return result
  return(result)
}

fun_fmt_result = function(result){
    result = result[ c(27:40, 
                       which(rownames(result)=="Fever"),
                       which(rownames(result)=="Rash"),
                       which(rownames(result)=="Shortness of breath"),
                       which(rownames(result)=="Eye-related"),
                       which(rownames(result)=="Diarrhoea"),
                       which(rownames(result)=="Vomiting"),
                       which(rownames(result)=="Cough"),
                       which(rownames(result)=="Runny nose"),
                       which(rownames(result)=="Sore throat"),
                       which(rownames(result)=="Headache"),
                       which(rownames(result)=="Dizziness"),
                       which(rownames(result)=="Chills"),
                       which(rownames(result)=="Abdominal pain"),
                       which(rownames(result)=="Nausea"),
                       which(rownames(result)=="Loss of appetite"),
                       which(rownames(result)=="Low back pain"),
                       which(rownames(result)=="Myalgia"),
                       which(rownames(result)=="Fatigue"),
                       which(rownames(result)=="ILI"),
                       which(rownames(result)=="ARI")),]
}

gee_GP = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_A")
write.xlsx(gee_GP,"Output table/20181010_gee_Type.xls", sheetName = "GP" )
# the gee_GP did not differ with original GEE in my 1st seminar

gee_GP_imp = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_A_imp")
write.xlsx(gee_GP_imp,"Output table/20181010_gee_Type.xls", sheetName = "GP_imp", append = T )

gee_GOPC = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_B")
write.xlsx(gee_GOPC,"Output table/20181010_gee_Type.xls", sheetName = "GOPC", append = T )

gee_GOPC_imp = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_B_imp")
write.xlsx(gee_GOPC_imp,"Output table/20181010_gee_Type.xls", sheetName = "GOPC_imp", append = T )

gee_CMP = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_C")
write.xlsx(gee_CMP,"Output table/20181010_gee_Type.xls", sheetName = "CMP", append = T )

gee_CMP_imp = fun_gee(data = abc_list[[1]], outcome = "HS1_C1_C_imp")
write.xlsx(gee_CMP_imp,"Output table/20181010_gee_Type.xls", sheetName = "CMP_imp", append = T )
