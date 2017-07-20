getEarthquakes <- function(){
  require(XML)
  xml <- xmlParse("http://udim.koeri.boun.edu.tr/zeqmap/xmlt/SonAY.xml")
  df <- data.frame(t(xpathSApply(xml,"//earhquake", "xmlAttrs")),stringsAsFactors=F)
  df$name <- as.POSIXct(df$name, format="%Y.%m.%d %H:%M:%S")
  df$lokasyon <- as.factor(df$lokasyon)
  df$lat <- as.numeric(df$lat)
  df$lng <- as.numeric(df$lng)
  df$mag <- as.numeric(df$mag)
  df$Depth <- as.numeric(df$Depth)
  return(df)
}
earthquakes <- getEarthquakes()
write.csv2(earthquakes, "earthquakes.csv",row.names = F)

########## Visualization ########## 
earthquakes <- read.csv2("earthquakes.csv")
earthquakes$name <- as.POSIXct(earthquakes$name)

library(ggplot2)
library(ggmap)

center <- sapply(earthquakes[,c("lng","lat")],mean)
map <- get_map(center,zoom = 6,maptype = "terrain")

require(scales)
ten_trans = function() trans_new("ten", function(x) 10^x, function(x) log10(x))

ggmap(map) +
  geom_point(aes(lng,lat,size=mag,alpha=mag), earthquakes, col="red")+
  scale_size(trans = "ten")+
  scale_color_continuous(trans= "ten")
