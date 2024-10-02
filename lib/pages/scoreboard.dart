import 'package:flutter/material.dart';

class SkorTablosuSayfasi extends StatefulWidget {
  final List<int> skorlar;
  final Function onSkorlariTemizle;

  const SkorTablosuSayfasi({super.key, required this.skorlar, required this.onSkorlariTemizle});

  @override
  State<SkorTablosuSayfasi> createState() => _SkorTablosuSayfasiState();
}

class _SkorTablosuSayfasiState extends State<SkorTablosuSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skor Tablosu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.skorlar.clear();
              widget.onSkorlariTemizle();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.skorlar.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${index + 1}. Tahmin Sayısı: ${widget.skorlar[index]}'),
            );
          },
        ),
      ),
    );
  }
}