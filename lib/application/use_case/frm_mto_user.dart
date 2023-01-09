import 'package:flutter/material.dart';

class frmMatoUser extends StatelessWidget {
  const frmMatoUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(children: [
          Card(
            child: TextField(),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Column(
              children: [
                TextField(),
                TextField(),
                TextField(),
                TextField(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
