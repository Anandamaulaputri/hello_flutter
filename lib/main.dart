import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isButterflyActive = true;

  void toggleTheme() {
    setState(() {
      isButterflyActive = !isButterflyActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Nanda',
      theme: ThemeData(
        useMaterial3: true,

        // 🌸 SOFT PINK (INI YANG BIKIN ESTETIK)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF8AFCF),
        ),

        scaffoldBackgroundColor: const Color(0xFFFFF7FB),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF7FB),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: ProfilPage(
        isAnimated: isButterflyActive,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  final bool isAnimated;
  final VoidCallback onThemeChanged;

  const ProfilPage({
    super.key,
    required this.isAnimated,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (isAnimated) ...[
            _bgButterfly(top: 100, left: 30),
            _bgButterfly(top: 200, right: 40),
            _bgButterfly(bottom: 150, left: 40),
            _bgButterfly(bottom: 80, right: 30),
          ],
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🌸 FOTO + KUPU-KUPU
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFFF8AFCF).withValues(alpha: 0.4),
                            blurRadius: 25,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 65,
                        backgroundColor: Color(0xFFF48FB1),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/nanda.jpeg'),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: -6,
                      right: -4,
                      child: Text('🦋', style: TextStyle(fontSize: 26)),
                    ),
                    const Positioned(
                      bottom: -4,
                      left: -6,
                      child: Text('🦋', style: TextStyle(fontSize: 22)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  'ANANDA MAULA PUTRI',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Times New Roman',
                  ),
                ),

                const SizedBox(height: 24),

                _infoCard(Icons.email, 'Email', 'ananda@poliban.ac.id'),
                _infoCard(Icons.phone, 'Telepon', '+62 858 2144 8961'),
                _infoCard(Icons.location_on, 'Alamat',
                    'Kalimantan Tengah, Muara Tuhup'),
                _infoCard(
                    Icons.language, 'Website', 'www.anandamaulaputri.dev'),

                const SizedBox(height: 24),

                // 🌸 BUTTON SOFT PINK
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF48FB1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Keluar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE88AB4),
                    side: const BorderSide(
                      color: Color(0xFFE88AB4),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListTile(
        leading: const Icon(Icons.auto_awesome),
        title: const Text('Toggle Kupu-Kupu'),
        trailing: Switch(
          value: isAnimated,
          onChanged: (value) {
            onThemeChanged();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFE4F1),
            child: Icon(icon, color: const Color(0xFFE88AB4)),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bgButterfly({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Opacity(
        opacity: 0.2,
        child: Text(
          '🦋',
          style: TextStyle(
            fontSize: 34,
            shadows: [
              Shadow(
                color: const Color(0xFFF8AFCF).withValues(alpha: 0.4),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
