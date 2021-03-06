import 'package:flutter/material.dart';

import '../main.dart';

class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({Key? key}) : super(key: key);
  static const id = 'NetworkErrorScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                const Text(
                  'Network Error...Connect to a network to continue',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 20.0,
                      letterSpacing: -0.03,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const MyApp()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size(365, 51),
                    ),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  icon: const Icon(
                    Icons.accessible_forward,
                    size: 24,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Try Again',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
