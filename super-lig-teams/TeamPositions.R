# 1. "Import Dataset" 
# 2. "From Excel"
# 3. "Browse"
# 4. "siralama.xlsx"
# 5. "Import"

# Satır (row) sayısı
nrow(siralama)
# Sütun (column) sayısı
ncol(siralama)

# 1.satır 1.sütun
siralama[1,1]
# 5.satır 4.sütun
siralama[5,4]

# 1.satır, (1.sütun hariç) hepsi
siralama[1, -1]

Akhisar.positions = siralama[ 1 , -1 ]
# Sayısal hale getir
Akhisar.positions = as.numeric(Akhisar.positions)
# Ortalama
mean(Akhisar.positions)

##### Veri Görselleştirme #####

# Nokta olarak göster
plot(Akhisar.positions)
# Çizgi olarak göster (plot üzerine ekler)
lines(Akhisar.positions)

# Sadece çizgi olarak göster 
# (bu şekilde öncesinde plot yazmadan da kullanılabilir)
plot(Akhisar.positions, type="l")

# Tüm takımları ekle
for (i in 1:18) {
  positions = siralama[ i , -1 ]
  positions = as.numeric(positions)
  lines(positions)
}

# Daha güzel görünüm için axis düzenlemesi yapalım
# 'axis limit'lerini belirleyelim, 'label' verelim

plot(Akhisar.positions,
     type="l",           # Çizgi grafik
     xlim = c(0, 30),    # X axis limitleri
     ylim = c(20, 0),    # Y axis limitleri (terse çevirdik)
     ylab = "Kaçıncı sırada", 
     xlab = "Hafta")

# Tüm takımları ekle
for (i in 1:18) {
  positions = siralama[  i , -1 ]
  positions = as.numeric(positions)
  lines(positions, col = i)
}

# 23.haftanın yanına takım isimlerini yazalım

text(23, siralama$H23, siralama$Team, adj = 0)

##### Satır ortalamaları ##### 

# Her takımın 23 haftalık sıralama ortalaması
satir_mean = rowMeans(siralama[,-1])
# Sonra da bunları toplayalım (amaçsızca)
sum(satir_mean)
# Ya da bu iki komutu tek satırda da yazabiliriz:
sum(rowMeans(siralama[,-1]))

##### Yeni veri oluşturma #####

yeni = siralama[,1]
yeni['Ortalama'] = apply(siralama[-1], 1, mean)
yeni['Ortalama son 5 hafta'] = apply(siralama[20:24], 1, mean)
yeni['Stdev'] = apply(siralama[-1], 1, sd)
yeni['Ilk 5te bulunma'] = apply(siralama[-1], 1, function(x) sum(x<6))

View(yeni)

# Author: Yiğit ÇETİNEL (ycetinel@gmail.com)