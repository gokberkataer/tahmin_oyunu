// ignore_for_file: library_private_types_in_public_api

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tahmin_oyunu/pages/scoreboard.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int _rastgeleSayi = 0;
  int _tahminSayisi = 0;
  String _geriBildirim = '';
  final TextEditingController _tahminKontrol = TextEditingController();
  List<int> _skorlar = [];

  @override
  void initState() {
    super.initState();
    _rastgeleSayiUret();
    _skorlariYukle();
  }

  void _rastgeleSayiUret() {
    _rastgeleSayi =
        (1 + (100 * (DateTime.now().millisecondsSinceEpoch % 100) / 100))
            .toInt();
    _tahminSayisi = 0; // Tahmin sayısını her yeni oyun başlangıcında sıfırla
    _geriBildirim = '';
    _tahminKontrol.clear();
  }

  void _tahminKontrolEt() {
    int tahmin = int.tryParse(_tahminKontrol.text) ?? 0;

    if (tahmin < 1 || tahmin > 100) {
      setState(() {
        _geriBildirim = 'Lütfen 1 ile 100 arasında bir sayı giriniz!';
      });
      return;
    }

    setState(() {
      _tahminSayisi++;
      if (tahmin < _rastgeleSayi) {
        _geriBildirim = 'Daha büyük bir sayı deneyin!';
      } else if (tahmin > _rastgeleSayi) {
        _geriBildirim = 'Daha küçük bir sayı deneyin!';
      } else {
        _geriBildirim = 'Tebrikler! Sayıyı $_tahminSayisi tahminde buldunuz!';
        _skorlar.add(_tahminSayisi);
        _skorlar.sort();
        _skorlariKaydet();
        _zaferPenceresiniGoster();
      }

      // Her tahmin sonrası TextField temizlensin
      _tahminKontrol.clear();
    });
  }

  void _zaferPenceresiniGoster() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tebrikler!'),
          content:
              Text('Doğru tahmin! Sayıyı $_tahminSayisi tahminde buldunuz.'),
          actions: [
            TextButton(
              child: const Text('Yeniden Oyna'),
              onPressed: () {
                Navigator.of(context).pop();
                _rastgeleSayiUret(); // Tahmin sayısını sıfırlamak için yeni sayı üret
              },
            ),
            TextButton(
              child: const Text('Skor Tablosu'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SkorTablosuSayfasi(
                      skorlar: _skorlar,
                      onSkorlariTemizle: _skorlariTemizle,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _skorlariKaydet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = _skorlar.map((i) => i.toString()).toList();
    prefs.setStringList('skorlar', stringList);
  }

  void _skorlariYukle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('skorlar');
    if (stringList != null) {
      setState(() {
        _skorlar = stringList.map((s) => int.parse(s)).toList();
      });
    }
  }

  void _skorlariTemizle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('skorlar');
    setState(() {
      _skorlar.clear();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Skorlar temizlendi! Sayfayı yenileyin.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayı Tahmin Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '1 ile 100 arasında bir sayı tahmin edin:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tahminKontrol,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Tahmininizi Girin',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _tahminKontrolEt,
                  child: const Text('Tahmin Et'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _geriBildirim,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Skor Tablosu',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SkorTablosuSayfasi(
                  skorlar: _skorlar,
                  onSkorlariTemizle: _skorlariTemizle,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
