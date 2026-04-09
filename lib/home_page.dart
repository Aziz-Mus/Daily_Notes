import 'package:flutter/material.dart';
import 'notes_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catatan Harian", 
          style: TextStyle(color: Colors.white)
          ),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal[700],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 30),
              child: Column(
                children: [
                  const Icon(Icons.book_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 15),
                  const Text(
                    "Selamat Datang!",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Tulis dan simpan catatan harimu",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                children: [
                  _menuCard(
                    context,
                    Icons.edit_note_rounded,
                    "Catatan Saya",
                    "Tulis dan kelola catatan",
                    NotesPage(),
                  ),
                  _menuCard(
                    context,
                    Icons.person_rounded,
                    "Profil Penulis",
                    "Lihat infromasi penulis",
                    ProfilePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _menuCard(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  Widget destination,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal[700]),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 18,
            ),
          ),
        ),
      ],
    ),
  );
}
