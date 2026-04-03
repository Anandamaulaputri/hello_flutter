import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

// MyApp sebagai StatefulWidget untuk mengelola status saklar animasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isButterflyThemeActive = false;

  void toggleTheme() {
    setState(() {
      isButterflyThemeActive = !isButterflyThemeActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Profil Nanda',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
      ),
      home: ProfilPage(
        isAnimated: isButterflyThemeActive,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}

// SESUAI KRITERIA 7: ProfilPage adalah StatelessWidget
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
        title: const Text('Profil Saya'), // Kriteria 1
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Kriteria 1 (Action Icon)
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Bonus Poin: Animasi Lottie (Network agar tidak error file)
          if (isAnimated)
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.3,
                ),
              ),
            ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Kriteria 2: Foto profil (assets/nanda.jpeg) dan Nama
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/nanda.jpeg'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ananda Maula Putri',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 24),
                
                // Kriteria 3: Minimal 4 Info Card
                _buildInfoCard(Icons.email, 'Email', 'anandamaulaputri@gmail.com'),
                _buildInfoCard(Icons.phone, 'Telepon', '085821448961'),
                _buildInfoCard(Icons.location_on, 'Alamat', 'Kalimantan Tengah'),
                _buildInfoCard(Icons.language, 'Website', 'www.anandamaulaputri.com'),
                
                const SizedBox(height: 24),
                
                // Kriteria 4: 2 Tombol dengan styling berbeda
                _buildButton(Icons.edit, 'Edit Profil', Colors.pink.shade50, Colors.black),
                const SizedBox(height: 8),
                _buildButton(Icons.logout, 'Logout', Colors.white, Colors.red, isOutlined: true),
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
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Aktifkan Tema Kupu-Kupu'),
            trailing: Switch(
              value: isAnimated,
              onChanged: (value) {
                onThemeChanged();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets untuk menjaga kode tetap rapi (Kriteria 6)
  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFEEEEEE)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink),
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, Color bgColor, Color textColor, {bool isOutlined = false}) {
    return SizedBox(
      width: double.infinity,
      child: isOutlined 
        ? OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(icon, color: textColor),
            label: Text(label, style: TextStyle(color: textColor)),
            style: OutlinedButton.styleFrom(side: BorderSide(color: textColor)),
          )
        : ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(icon, color: textColor),
            label: Text(label, style: TextStyle(color: textColor)),
            style: ElevatedButton.styleFrom(backgroundColor: bgColor, elevation: 0),
          ),
    );
  }
}