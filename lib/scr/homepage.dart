import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'BookingPage.dart';
import 'FramesPage.dart';
import 'PricePage.dart';
import 'ReviewPage.dart';
import 'photos.dart';
import 'login.dart'; 
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 140, 158),
              ),
              child: Text(
                'App Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Navigate to the login page and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Lottie.asset(
            'assets/snowman.json',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BootstrapContainer(
            fluid: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhotosPage()),
                        );
                      },
                      text: 'Photos',
                      icon: Icons.photo,
                      context: context,
                    ),
                    _buildButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FramesPage()),
                        );
                      },
                      text: 'Frames',
                      icon: Icons.image,
                      context: context,
                    ),
                    _buildButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PricesPage()),
                        );
                      },
                      text: 'Price',
                      icon: Icons.monetization_on,
                      context: context,
                    ),
                    _buildButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingPage()),
                        );
                      },
                      text: 'Booking',
                      icon: Icons.book,
                      context: context,
                    ),
                    _buildButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReviewPage()),
                        );
                      },
                      text: 'Review',
                      icon: Icons.rate_review,
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithIcon({
    required Function onPressed,
    required String text,
    required IconData icon,
    required BuildContext context,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width * 0.5,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 77, 112),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton.icon(
        onPressed: onPressed as void Function()?,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
