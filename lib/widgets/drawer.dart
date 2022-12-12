import 'package:flutter/material.dart';
import 'package:medstem/pages/kasir/kasir.dart';
import 'package:medstem/main.dart';
import 'package:medstem/pages/childcare/childcare.dart';
import 'package:medstem/pages/vaksin/vaccine_data_page.dart';
import 'package:medstem/login.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({Key? key}) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<DrawerClass> {
    @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // other children,
          ListTile(
            leading: Icon(Icons.home_work),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: "Homepage")),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Login"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: const Text("Childcare"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChildcarePage(title: "Childcare")),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.vaccines),
            title: Text("Vaksin"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VaccineDataPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout_outlined),
            title: Text("Checkout"),
            onTap: () {
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
