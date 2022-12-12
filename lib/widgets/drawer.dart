import 'package:flutter/material.dart';
import 'package:medstem/pages/apotek/apotek.dart';
import 'package:medstem/pages/kasir/kasir.dart';
import 'package:medstem/main.dart';
import 'package:medstem/pages/childcare/childcare.dart';
import 'package:medstem/pages/vaksin/vaccine_data_page.dart';
import 'package:medstem/login.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:medstem/pages/checkup/checkup.dart';

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

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    bool status = request.loggedIn;
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
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Homepage")),
              );
            },
          ),
          if (status)...[
            ListTile(
            leading: Icon(Icons.people),
            title: Text("Logout"),
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: "Homepage")),
              );
               final response = await request.logout(
                  'https://medstem.up.railway.app/logout-flutter/');
            },
          ),
          ]else...[
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
          ],
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: const Text("Childcare"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ChildcarePage(title: "Childcare")),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.vaccines),
            title: Text("Vaksin"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const VaccineDataPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.medication_liquid_sharp),
            title: Text("Pharmacy"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ApotekMainPage()),
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
          ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text("Checkup"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CheckupPage(title: "Checkup")));
              }),
        ],
      ),
    );
  }
}
