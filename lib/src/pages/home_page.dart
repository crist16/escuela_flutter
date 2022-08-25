import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            FadeInImage(
                image: AssetImage("assets/img/cintillo.png"),
                placeholder: AssetImage("assets/img/no-image.jpg")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "prosecucion");
                },
                child: const Text("Constancia de prosecucion"))
          ],
        ),
      ),
    );
  }
}
