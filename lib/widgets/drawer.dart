import 'package:flutter/material.dart';
import 'package:medstem/pages/kasir/kasir.dart';
import 'package:medstem/main.dart';
import 'package:medstem/pages/childcare.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
              );
            },
          ),
          ListTile(
                title: const Text('Childcare'),
                onTap: () {
                  // Route menu ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Childcare()),
                  );
                },
              ),
          ListTile(
            title: const Text('Checkout'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Kasir()),
              );
            },
          ),
        ],
      ),
    );
  }
}
