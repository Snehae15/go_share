import 'package:flutter/material.dart';

class Offer_view extends StatelessWidget {
  const Offer_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          'GO Share',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff068DA9),
            fontFamily: 'Times New Roman',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:300.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showCompletionAlert(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // Set the button color here
                  ),
                  child: Text('Open Offer'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompletionAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Offer'),
          content: Text('You can only open this when you complete a trip.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
