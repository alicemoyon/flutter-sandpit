import 'package:flutter/material.dart';

// custom FlavourCard widget

class FlavourCard extends StatelessWidget {
  final String flavourName;
  final String flavourDesc;
  final Color flavourCol;
  final String flavourImgLoc;

  const FlavourCard(
      this.flavourName, this.flavourDesc, this.flavourCol, this.flavourImgLoc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          child: Image.asset(
            "$flavourImgLoc",
          ),
          height: 72,
          width: 72,
        ),
        title: Text(
          "$flavourName",
          style: TextStyle(color: flavourCol, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$flavourDesc"),
      ),
    );
  }
}
