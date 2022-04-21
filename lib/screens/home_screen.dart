import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/network_provider.dart';
import 'package:weather_app/style/constants.dart';
import 'package:weather_app/screens/get_weather_condition_screen.dart';
import 'package:weather_app/widgets/error_messages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 40),
                child: TextFormField(
                  controller: _locationNameController,
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Location is required'
                        : null;
                  },
                  style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: 'poppins',
                      height: 1.3),
                  decoration: kCountryInputDecorationStyle.copyWith(
                      labelText: 'Search a Location...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var networkProvider = Provider.of<NetworkInfoImpl>(
                            context,
                            listen: false);
                        await networkProvider.checkNewtworkStatus();
                        if (networkProvider.networkStatus == true) {
                          
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WeatherConditionScreen(
                                    locationName: _locationNameController.text,
                                  )));
                          // _locationNameController.clear();
                        } else {
                          networkAlertMessage(context);
                        }
                      }
                    },
                    minWidth: 365,
                    height: 51,
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: const Text(
                      'Get weather',
                      style: TextStyle(
                          color: Color(
                            0xffF6F6F9,
                          ),
                          fontSize: 17,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
