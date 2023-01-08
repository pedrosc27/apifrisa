import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OringsPage extends StatelessWidget {
  const OringsPage({Key? key}) : super(key: key);

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
        "https://api.whatsapp.com/send/?phone=5218183369539&text&app_absent=0");

  
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarilloFrisa,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: negroFrisa,
          ),
        ),
        title: const Text(
          "O'rings",
          style: TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/magnifier.png",
              width: 90,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Productos no encontrados",
              style: TextStyle(
                  fontSize: 18,
                  color: negroFrisa,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Comunicate con nosotros, podemos apoyarte con el O'rings que estas buscando",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: negroFrisa,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (() async {
                _launchUrl();
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    color: negroFrisa,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Enviar mensaje',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'NeoMedium',
                          color: amarilloFrisa,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
