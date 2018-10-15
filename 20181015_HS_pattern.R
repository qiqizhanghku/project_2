
trigger = col_HS2B_1
symptom = col_newSS4_1



col_of_trigger = c(col_HS2B_1:(col_HS2B_1+22), col_anyTrigger_ILI, col_anyTrigger_ARI)
col_of_symptom = c(col_newSS4_1:(col_newSS4_1+22), col_ILI, col_ARI)
dataset = abc_list[[1]]
hs_pattern_tb = data.frame(matrix(nrow = length(col_of_trigger), ncol = 4))
for( i in 1:length(col_of_trigger)){
  hs_pattern_tb[i,] = table(dataset[,col_of_trigger[i]], dataset$round)["1",]/table(dataset[,col_of_symptom[i]], dataset$round)["1",]
}

names(hs_pattern_tb) = paste("Round",1:4,sep = "_")
rownames(hs_pattern_tb) = c(symdrome_name_grouped, "ILI", "ARI")

png("Output plot/20181015_HS_pattern_table_raw.png", height=1900, width=3000,res=250)
par(mfrow=c(5,5))


for( i in 1:length(col_of_trigger)){
  plot(c(1, 4), c(0,1), bty='n', pch="", xlab = rownames(hs_pattern_tb)[i])  # ,ylab='',xlab='', xaxt='n',yaxt='n'
  lines(y = hs_pattern_tb[i,], x = 1:4, col = "blue", pch=16) # i+(i-1)*1.5
  
  }
dev.off()


# 
# write.xlsx(hs_pattern_tb,"Output table/20181015_HS_pattern_table_raw.xls")
# 
# 
# hs_pattern_tb[i,2]





