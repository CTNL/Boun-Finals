# Boun Final Analyzer by Yiðit Çetinel

# Parse data from registration website ---------
library(XML)
list <- readHTMLTable("http://registration.boun.edu.tr/scripts/coursefinalprogram.asp?e=FINAL&p=BYCOURSE", 
                      as.data.frame = F)[[1]]
# Analyze exam dates ---------------------------
library(lubridate)
exam_dates <- dmy(list$`Exam Date`)
# Frequency table
hangi_gun <- table(exam_dates)
plot(hangi_gun, type = "b")

# Analyze slots --------------------------------
hangi_slot <- table(list$`Exam Slot`)
barplot(hangi_slot)

# Parse student number as integer
list$Student <- as.integer(gsub("[^0-9]","",list$Instructor))
plot(exam_dates, list$Student)
# Aggregate by date - Mean
gun_ogrenci_orta <- aggregate(Student ~ exam_dates, list, mean)
plot(gun_ogrenci_orta, type="b")
# Aggregate by date - Total
gun_ogrenci_toplam <- aggregate(Student ~ exam_dates, list, sum)
plot(gun_ogrenci_toplam, type="c")
text(gun_ogrenci_toplam, labels = gun_ogrenci_toplam$Student, srt=90)
