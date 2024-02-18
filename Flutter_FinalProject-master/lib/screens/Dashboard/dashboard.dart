import 'package:crud/bloc/sign_in/sign_in_bloc.dart';
import 'package:crud/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Set the app bar color
      bottomNavigationBar: BottomAppBar(
        height: 65,
        // color: Colors.white60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {},
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        // elevation: 50,
        toolbarHeight: 100,
        backgroundColor: Colors.grey[300], // Set the app bar color
        automaticallyImplyLeading: false,
        // title:
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignOutRequired());
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 30,
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[500],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 150),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text("Home", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text("About", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the About screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text("Settings",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.grey[400]),
                title: Text("User Profile",
                    style: TextStyle(color: Colors.grey[400])),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Home screen
                  Navigator.pushReplacement(
                    //check alignment sign up > profile else login > home page
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("Good Morning"),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Hello Asad Virani, Arisha, Aaliyah, Aman, Ahsan",
              style: GoogleFonts.notoSerif(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(25),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1 / 1.3,
              children: [
                _buildMenuButton(
                  icon: Icons.view_list,
                  color: Colors.green,
                  label: "Asad",
                  onPressed: () {},
                ),
                _buildMenuButton(
                  icon: Icons.shopping_cart,
                  color: Colors.yellow,
                  label: "Aman",
                  onPressed: () {},
                ),
                _buildMenuButton(
                  icon: Icons.shopping_basket,
                  color: Colors.brown,
                  label: "Aaliyah",
                  onPressed: () {},
                ),
                _buildMenuButton(
                  icon: Icons.history_outlined,
                  color: Colors.blue,
                  label: "Arisha",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required color,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: color[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Icon(
              icon,
              size: 60,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
            MaterialButton(
              onPressed: onPressed,
              color: color,
              child: const Text(
                "VIEW",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ]),
    );
  }
}
