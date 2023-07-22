import 'package:corider/Home/offer.dart';
import 'package:flutter/material.dart';
// Replace with the correct path for offerpool.dart

class Offer_view extends StatefulWidget {
  const Offer_view({Key? key}) : super(key: key);

  @override
  State<Offer_view> createState() => _OfferViewState();
}

class _OfferViewState extends State<Offer_view> {
  @override
  void initState() {
    super.initState();
    // Show the completion alert directly when the widget is created
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showCompletionAlert(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Your app bar code
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Your body content
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
          content: Text(
              'You Successfully completed a trip and also achieved an offer. '
                  'Click the ok button to achieve it.note:you can only select '
                  'one offer at a time and claim the offer parrellaly with your'
                  ' licence id and vehicle number'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigate to the Offerpool page when "Ok" is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllOffer(),
                  ),
                );
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
