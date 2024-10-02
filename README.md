# case_study

# Sayı Tahmin Uygulaması
Bu uygulama, 1 ile 100 arasında rastgele seçilen bir sayıyı tahmin etmeye dayalı basit ve eğlenceli bir oyundur. Kullanıcı her tahminde ipuçları alarak sayıyı doğru tahmin etmeye çalışır ve tahmin sayısı skor olarak kaydedilir.

## Özellikler
- **Rastgele Sayı Üretimi**: 1 ile 100 arasında bir sayı rastgele seçilir.
- **Tahmin Kontrolü**: Kullanıcı tahmin yapar ve doğru tahmin edilene kadar geri bildirim alır ("Daha büyük" ya da "Daha küçük").
- **Skor Kaydı**: Kullanıcı doğru tahmini yaptığında, kaç tahminde sonuca ulaştığı skor olarak kaydedilir.
- **Skor Tablosu**: Kullanıcının geçmiş tahminleri ve başarıları saklanır, skor tablosunda gösterilir.
- **Skorları Temizleme**: Kullanıcı istediğinde skor tablosunu temizleyebilir.
- **Veri Saklama**: Skorlar, cihazda kalıcı olarak **SharedPreferences** kullanılarak saklanır.

## Ekranlar
- **Ana Sayfa**: Kullanıcı, sayı tahminini yapar ve geri bildirim alır.
- **Skor Tablosu**: Geçmişte yapılan tahminlerin listelendiği skor tablosu görüntülenir. Ayrıca skorları temizleme imkanı sunar.

## Kurulum
Bu projeyi yerel makinenizde çalıştırmak için şu adımları izleyin:

### Gereksinimler
- Flutter SDK: [https://flutter.dev](https://flutter.dev)
- Android Studio, Xcode veya bir emülatör