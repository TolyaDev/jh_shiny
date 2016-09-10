data.nei <- data.table(readRDS('data/summarySCC_PM25.rds'))

data.nei$year <- factor(data.nei$year)
data.nei$type <- factor(data.nei$type)
data.nei.baltimore <- subset(data.nei, fips == "24510")
# data.nei.baltimore[,summ:=sum(Emissions), by=list(year, type)]

# data.scc <- data.table(readRDS('data/Source_Classification_Code.rds'))
# 
# type.numbers <- data.scc[grep(x = data.scc$EI.Sector, pattern='[Cc]omb.*[Cc]oal')]$SCC
# data.nei.sub <- data.nei[SCC %in% type.numbers]
# data.nei.sub[,summ:=sum(Emissions), by=year]

write.csv(data.nei.baltimore, 'data_nei_baltimore.csv')