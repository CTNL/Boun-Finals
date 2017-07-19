zar1 <- sample(6, 20, replace=T)
zar2 <- sample(6, 20, replace=T)

plot(zar1)
points(zar2,pch=2)

paste( sum(zar1==zar2), "times, draw.")
paste( sum(zar1>zar2),  "times, player 1 won.")
paste( sum(zar1<zar2),  "times, player 2 won.")
