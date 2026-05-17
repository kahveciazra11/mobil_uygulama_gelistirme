import 'package:flutter/material.dart';

void main() {
  runApp(const BenimUygulamam());
}

class BenimUygulamam extends StatelessWidget {
  const BenimUygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaNavigatorEkrani(),
    );
  }
}


class AnaNavigatorEkrani extends StatefulWidget {
  const AnaNavigatorEkrani({super.key});

  @override
  State<AnaNavigatorEkrani> createState() => _AnaNavigatorEkraniState();
}

class _AnaNavigatorEkraniState extends State<AnaNavigatorEkrani> {
  int _secilenSayfaIndex = 0;

  final List<Widget> _sayfalar = [
    const UrunListesiEkrani(), 
    const BasitSepetEkrani(),   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sayfalar[_secilenSayfaIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _secilenSayfaIndex,
       
        selectedItemColor: Colors.pinkAccent, 
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _secilenSayfaIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Sepetim'),
        ],
      ),
    );
  }
}


class Urun {
  final String urunAdi;
  final String urunAciklamasi;
  final String urunFiyati;
  final String fotografLinki;

  const Urun({
    required this.urunAdi,
    required this.urunAciklamasi,
    required this.urunFiyati,
    required this.fotografLinki,
  });
}


const List<Urun> tumUrunler = [
  Urun(
    urunAdi: 'Akıllı Telefon',
    urunAciklamasi: 'Zarif tasarımıyla dikkat çeken, harika kameralı  akıllı telefon.',
    urunFiyati: '25.000 TL',
    fotografLinki: 'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=400', 
  ),
  Urun(
    urunAdi: ' Kulaklık',
    urunAciklamasi: 'Müzik dinlemek için çok şık. Şarjı uzun süre gidiyor, ses kalitesi yüksek.',
    urunFiyati: '1.500 TL',
    fotografLinki: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400', 
  ),
  Urun(
    urunAdi: ' Fare',
    urunAciklamasi: 'Masanıza renk katacak ergonomik ve hızlı tepki veren mouse.',
    urunFiyati: '800 TL',
    fotografLinki: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400', 
  ),
  Urun(
    urunAdi: ' Sırt Çantası',
    urunAciklamasi: 'Günlük kullanım için ideal, su geçirmez kumaşlı  çanta.',
    urunFiyati: '1000 TL',
    fotografLinki: 'https://images.unsplash.com/photo-1546938576-6e6a64f317cc?w=400', 
  ),
];


class UrunListesiEkrani extends StatelessWidget {
  const UrunListesiEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text('Ürün Kataloğu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tumUrunler.length,
          itemBuilder: (context, index) {
            final urun = tumUrunler[index];
            return Card(
              elevation: 2,
              color: Colors.white, 
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UrunDetayEkrani(secilenUrun: urun)),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        urun.fotografLinki, 
                        fit: BoxFit.cover, 
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(urun.urunAdi, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(urun.urunFiyati, style: const TextStyle(color: Colors.pinkAccent)), 
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class UrunDetayEkrani extends StatelessWidget {
  final Urun secilenUrun;
  const UrunDetayEkrani({super.key, required this.secilenUrun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(secilenUrun.urunAdi, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(secilenUrun.fotografLinki, height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(secilenUrun.urunAdi, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(secilenUrun.urunFiyati, style: const TextStyle(fontSize: 20, color: Colors.pinkAccent, fontWeight: FontWeight.bold)), // Fiyat pembe
                const Divider(),
                const Text('Ürün Açıklaması:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(secilenUrun.urunAciklamasi, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${secilenUrun.urunAdi} sepete eklendi!'),
                          backgroundColor: Colors.pinkAccent, 
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), 
                    child: const Text('Sepete Ekle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class BasitSepetEkrani extends StatefulWidget {
  const BasitSepetEkrani({super.key});

  @override
  State<BasitSepetEkrani> createState() => _BasitSepetEkraniState();
}

class _BasitSepetEkraniState extends State<BasitSepetEkrani> {
  bool sepetDoluMu = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sepetim', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            sepetDoluMu
                ? Card(
                    color: Colors.pink.shade50, 
                    child: ListTile(
                      leading: const Icon(Icons.phone_android, color: Colors.pinkAccent, size: 40),
                      title: const Text('Pembe Akıllı Telefon', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('Adet: 1'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey), 
                        onPressed: () {
                          setState(() {
                            sepetDoluMu = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ürün sepetten silindi!'),
                              backgroundColor: Colors.pinkAccent,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Sepetiniz Boş', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                  ),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Toplam Tutar:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    sepetDoluMu ? '25.000 TL' : '0 TL',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: sepetDoluMu
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Alışveriş tamamlandı! 🎉'),
                            backgroundColor: Colors.pinkAccent,
                          ),
                        );
                      }
                    : null, 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                child: const Text('Alışverişi Tamamla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
