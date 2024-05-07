CREATE DATABASE vtys_db;
USE vtys_db;
       
CREATE TABLE IF NOT EXISTS ucak (
ucak_id INT PRIMARY KEY,
model VARCHAR(50),
seri_no VARCHAR(20),
uretim_yili INT CHECK (uretim_yili >= 0)
);

CREATE TABLE IF NOT EXISTS pilot (
pilot_id INT PRIMARY KEY,
ad VARCHAR(50),
soyad VARCHAR(50),
yas TINYINT,
lisans_no VARCHAR(20) CHECK (lisans_no IS NOT NULL),
ucak_p INT,
FOREIGN KEY (ucak_p) REFERENCES ucak(ucak_id)
);

CREATE TABLE IF NOT EXISTS ucuslar (
ucus_id INT PRIMARY KEY,
pilot_id INT,
ucak_id INT,
kalkis_yeri VARCHAR(50),
varis_yeri VARCHAR(50),
ucus_tarihi DATETIME,
varis_tarihi DATETIME,
FOREIGN KEY (pilot_id) REFERENCES pilot (pilot_id),
FOREIGN KEY (ucak_id) REFERENCES ucak (ucak_id)
);

INSERT INTO ucak (ucak_id, model, seri_no, uretim_yili) VALUES
(1, 'Boeing 737', 'S123', 2015),
(2, 'Airbus A320', 'S456', 2018),
(3, 'Embraer E175', 'S789', 2020),
(4, 'Bombardier CRJ900', 'S987', 2017),
(5, 'Boeing 777', 'S654', 2016),
(6, 'Airbus A380', 'S321', 2019),
(7, 'Embraer E175', 'S789', 2021),
(8, 'Bombardier CRJ900', 'S123', 2014),
(9, 'Boeing 787', 'S456', 2013),
(10, 'Airbus A380', 'S987', 2012);

INSERT INTO pilot (pilot_id, ad, soyad, yas, lisans_no, ucak_p) VALUES
(1, 'Ahmet', 'Yılmaz', 40, 'L-123', 1),
(2, 'Mehmet', 'Demir',  45, 'L-456', 2),
(3, 'Ayşe', 'Kaya', 38, 'L-789', 1),
(4, 'Fatma', 'Öztürk', 39, 'L-987', 3),
(5, 'Ali', 'Çelik', 42, 'L-654', 2),
(6, 'Elif', 'Yıldız', 28, 'L-321', 1),
(7, 'Mustafa', 'Arslan', 32, 'L-789', 3),
(8, 'Zeynep', 'Şahin',  43, 'L-123', 2),
(9, 'Okan', 'Aydın', 41, 'L-456', 1),
(10, 'Ebru', 'Türk', 35, 'L-987', 3);

INSERT INTO ucuslar (ucus_id, pilot_id, ucak_id, kalkis_yeri, varis_yeri, ucus_tarihi,varis_tarihi) VALUES
(1, 1, 1, 'İstanbul', 'Ankara', '2023-01-01 15:00','2023-01-01 16:10'),
(2, 2, 2, 'Ankara', 'İzmir', '2023-03-02 23:55', '2023-03-03 01:15'),
(3, 3, 3, 'İzmir', 'Ankara', '2023-08-03 18:00','2023-08-03 19:20'),
(4, 4, 4, 'Antalya', 'İstanbul', '2023-04-04 06:05', '2023-04-04 07:20'),
(5, 5, 5, 'Adana', 'İstanbul', '2023-07-05 02:30', '2023-07-05 04:15'),
(6, 6, 6, 'Bursa', 'Gaziantep', '2023-07-06 16:55', '2023-07-06 18:00'),
(7, 7, 7, 'Gaziantep', 'İzmir', '2023-06-07 06:00', '2023-06-07 07:20'),
(8, 8, 8, 'İzmir', 'Mardin', '2023-04-08 08:10', '2023-04-08 09:10'),
(9, 9, 9, 'Trabzon', 'Mersin', '2023-02-09 06:35', '2023-02-09 08:20'),
(10, 7, 7, 'Erzurum', 'İstanbul', '2023-05-10 10:45', '2023-05-10 12:35'),
(11, 6, 6, 'Erzurum', 'İstanbul', '2023-05-12 10:45', '2023-05-12 12:35'),
(12, 4, 4, 'Adana', 'İstanbul', '2023-10-05 02:30', '2023-10-05 04:15'),
(13, 3, 3, 'Antalya', 'İstanbul', '2023-06-04 06:05', '2023-06-04 07:20'),
(14, 8, 8, 'İzmir', 'Mardin', '2023-05-08 08:10', '2023-05-08 09:10');


/* Tabloya yeni kayıt ekleme */
INSERT INTO pilot (pilot_id, ad, soyad, yas, lisans_no, ucak_p) VALUES (11, 'Mert', 'Kaya', 29, 'L-111', 1);

/* Tablo güncellemesi: id'si 1 olan uçağın modelini Boeing 747 olarak değiştirdik. */
UPDATE ucak SET model = 'Boeing 747' WHERE ucak_id = 1;

/* Tablodan veri silme işlemi: id'si 1 olan uçuş bilgisini sildik */
DELETE FROM ucuslar WHERE ucus_id = 1;


/* 'L-123', 'L-987', 'L-789' numaralı lisansa sahip olmayanları listeleyelim. */
SELECT * FROM pilot WHERE lisans_no NOT IN ('L-123', 'L-987', 'L-789');

/* Bu sorguda Airbus ile başlayan uçakların bilgisini aldık. */
SELECT * FROM ucak WHERE model LIKE 'Airbus%';

/* Bu sorguda ucuslar tablosundan kalkış yeri İzmir,
varış yeri Ankara olan veya varış yeri Mardin olan ve ucak_id'si 8 olmayan tüm uçuşların bilgilerini
aldık. Sorguda "or, and, not" ifadelerinin hepsini göstermek istedik. Ondan dolayı 1 kayıda ulaşabildik. */
SELECT * FROM ucuslar WHERE kalkis_yeri = 'İzmir' AND varis_yeri = 'Ankara' OR varis_yeri = 'Mardin' AND NOT ucak_id = 8;


/* Nisan ve temmuz ayları arasında yapılacak uçuşları küçükten büyüğe doğru görüntüleyelim. */
SELECT * FROM ucuslar WHERE MONTH(ucus_tarihi) BETWEEN 4 AND 7 ORDER BY ucus_tarihi ASC;

/* Pilot bilgisi yazdıralım. */
SELECT CONCAT(UPPER(SUBSTR(ad, 1, 1)), '. ', UPPER(soyad),' ', yas,' ', 'yaşında', ' ',lisans_no,' ', 'nolu lisansa sahiptir.') AS pilot_bilgisi
FROM pilot ORDER BY yas;

/* Pilotların ortalama uçuş sürelerini dakika cinsinden bulalım. 'TIMESTAMPDIFF' ile iki zaman 
aralığındaki farkı bulup 'MINUTE' ile bunun dakika cinsinden olmasını istediğimizi belirtiyoruz.
'AVG' ile ortalamasını alıyoruz. */
SELECT AVG(TIMESTAMPDIFF(MINUTE, ucus_tarihi, varis_tarihi)) AS ortalama_ucus FROM ucuslar;


/* Birden fazla olan uçak modellerini sorgulayalım. */
SELECT model, COUNT(*) AS ucak_sayisi FROM ucak GROUP BY model HAVING COUNT(model) >= 2 ORDER BY model ASC;

/* Hangi şehirden kaç adet kalkış yapıldığını büyükten küçüğe doğru sorgulayalım. */
SELECT kalkis_yeri, COUNT(*) AS Adet FROM ucuslar GROUP BY kalkis_yeri ORDER BY Adet DESC;

/* Uçak tablosunda hangi modelden kaç adet olduğunu ve ortalama üretim yılını gösteren bir sorgu yazalım.
Sonucu model adına göre artan şekilde sıralayalım.
Üretim yılı 2010’dan küçük olan modelleri görüntülenmesin. */
SELECT model, COUNT(ucak_id) AS ucak_sayisi, CAST(AVG(uretim_yili) AS SIGNED) AS uretim_yili_ort FROM ucak GROUP BY model HAVING AVG(uretim_yili) >= 2010 ORDER BY model ASC;


/* INNER JOIN: "ucuslar" ve "pilot" tablolarını "pilot_id" alanını birleştirdik, her uçuşun pilot-uçak bilgilerini göstermeyi amaçladık.*/
SELECT ucuslar.*, pilot.ad, pilot.soyad FROM ucuslar INNER JOIN pilot ON ucuslar.pilot_id = pilot.pilot_id;

/* RIGHT JOIN: "ucuslar" tablosunu "pilot_id" alanı üzerinden join işlemi yaparak "pilot" tablosuyla birleştirdik. Eşleşme olmazsa ilgili alanlar NULL olur. */
SELECT ucuslar.*, pilot.ad, pilot.soyad FROM ucuslar RIGHT JOIN pilot ON ucuslar.pilot_id = pilot.pilot_id;

/* "ucak" tablosunu "ucak_id" alanı üzerinden sol join işlemi yaparak "pilot" tablosuyla birleştirdik.
Uçak bilgilerini eşleşen pilotlarla birlikte verir, eşleşmeyen alanları ise NULL olarak döndürür. */
SELECT ucak.*, pilot.ad, pilot.soyad FROM ucak LEFT JOIN pilot ON ucak.ucak_id = pilot.ucak_p;

