#Getting data in
#creating variables
coffee.mon<-3
coffee.mon
coffee.tues=4

coffeeweek<-c(3,2,5,8,6,4,1)
teaweek<-c(30,22,43,26,45,53,64)
week<-c("m","t","w","th","f","s","sn")
week
coffeeweek

#Prelim plotting
plot(coffeeweek, teaweek)
boxplot(coffeeweek, teaweek, xlab="beverages")

beverage = matrix(c( coffeeweek, 2, 5, 9, 2, 7, 9, 2), nrow=7, ncol=2)
plot(beverage[,1], beverage[,2])

#plot without suspect data point
plot(beverage[-7,1], beverage[-7,2], xlab="coffee", ylab="tea")

#Mainpulating data
volcoffee<-beverage[,1]*250voltea<-beverage[,2]*200
fluids<-volcoffee+volteaweekfluids<-sum(fluids)
weekfluids
mfluids<-mean(fluids)mfluids

#Statistical tests and corresponding plots
t.test(volcoffee,voltea)
boxplot(volcoffee, voltea, names=c("coffee", "tea"))

#Same result
aov.ct = aov(volcoffee~voltea)  #do the analysis of variance
summary(aov.ct) 


#Correlation                           
cor.ct<-cor(volcoffee~voltea)
plot(volcoffee~voltea)

#Read in data file
hogdata<-read.csv(file.choose(), header=TRUE)

#One-way anova
anova(lm(burns~land.use, data=hogdata))

#plot
boxplot(burns~land.use, data=hogdata, ylab="burns")





#Linear regression
lreg.burns<-lm(burns~density, data=hogdata)
summary(lreg.burns)
plot(burns~density, data=hogdata)
abline(lreg.burns, col="red")
title("Reported hogweed burns for a given plant \n density: observed and best fit line")
legend("topleft", pch=c(1,0), lty=c(0,1), c("data", "regression"))

#Two-way anova
an2.burns<-lm(burns~land.use*localization, data=hogdata)
#Type I SS
anova(an2.burns)
#Type III SS
t3an2.burns<-drop1(anc.burns,~.,test="F") 
TukeyHSD(aov(an2.burns))


#plot interation grapj
attach(hogdata)
interaction.plot(land.use, localization, burns)
detach(hogdata)

#plot barchart with error bars
mean.burns<-tapply(hogdata$burns, list(hogdata$localization), mean)
sd.burns<-tapply(hogdata$burns, list(hogdata$localization), sd)
n.burns<-tapply(hogdata$burns, list(hogdata$localization), length)
mids<-barplot(mean.burns, xlab="plant distribution", ylab="burns", ylim=c(0, 7))
arrows(mids, mean.burns-sd.burns, mids, mean.burns+sd.burns, code=3, angle=90, length=0.01)
text(mids, 6, paste("n=", n.burns))

#ANCOVA
anc.burns<-lm(burns~density*localization, data=hogdata)
anova(anc.burns)

#plot regression lines for each category and save plot as jpg

jpeg("/Users/Kim/myplot.jpg")
plot(burns~density, data=hogdata, pch=19, cex=1.5, col=c("black", "red")[hogdata$localization], xlab="density", ylab="burns")
legend("bottomright", legend=c("spread", "local"), col=c("black", "red"), pch=c(19, 19))
new.x<-expand.grid(density=unique(hogdata$density), localization=levels(hogdata$localization))
anclines<-predict(anc.burns, newdata=new.x)
preds<-data.frame(new.x,anclines)
idx <- order(preds$density)
sorted <- preds[idx,]
lines(anclines~density, data=subset(sorted, localization=="spread"))
lines(anclines~density, subset(sorted, localization=="local"), col="red")
dev.off()
