
start <- as.Date("2019-06-14")
end <- as.Date("2020-11-23")

#get the csv files 
ETH <- (read.csv("~/Downloads/ETH-USD.csv"))
ETHE <- (read.csv("~/Downloads/ETHE.csv"))

#create dataframes and consolidate/wrangle data
prices<- merge.data.frame(ETH, ETHE, by = "Date", all.ETH = TRUE, all.ETHE = TRUE)
stocks <- (data.frame(Date = (as.Date(prices[, "Date"])),ETH = (prices[, "Close.x"]), ETHE = (prices[, "Close.y"])))
stocks$Date <- ymd(stocks$Date) #convert date from character to timestamp
premium <- data.frame(ETHprem = (as.numeric(stocks$ETHE)/(.096*as.numeric(stocks$ETH)) -1)*100)
stockPremiums <- (cbind(stocks, premium))

#plot ETH-USD, ETHE, the premium to NAV of ETHE, first and third quartile ranges 
plot(stockPremiums$Date, stockPremiums$ETH, type = "l", col = 1, main = "ETHE Premium", xlab = "Dates: 06/14/19 to 11/23/20", ylab = "Price", ylim = c(0, 1000))
lines(stockPremiums$Date, stockPremiums$ETHE, type = "l", col = 2)
lines(stockPremiums$Date, stockPremiums$ETHprem, type = "l", col = 3, lwd = 3)
abline(h=quantile(stockPremiums$ETHprem, 0.25), col="purple", lty=2)
abline(h=quantile(stockPremiums$ETHprem,0.75),col="purple",lty=2)

legend("topright", c("ETH", "ETHE", "Premium %"), col = c("black", "red", "green"), lty = 1, cex = 0.5)

summary(stockPremiums$ETHprem)



