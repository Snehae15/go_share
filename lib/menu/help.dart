import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class help extends StatelessWidget {
  const help({Key? key}) : super(key: key);

  // Function to make a phone call
  void _makePhoneCall(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'GO Share',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff068DA9),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                //app name
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 600,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ListTile(
                      leading: Icon(Icons.local_police_outlined),
                      title: Text(
                        'Police',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        '100',
                        style: TextStyle(fontSize: 22),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _makePhoneCall('100');
                        },
                        child: Icon(
                          Icons.call,
                          color: Color(0xff068DA9),
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return ListTile(
                      leading: Icon(Icons.local_fire_department),
                      title: Text(
                        'Fire Force',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        '101',
                        style: TextStyle(fontSize: 22),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _makePhoneCall('101');
                        },
                        child: Icon(
                          Icons.call,
                          color: Color(0xff068DA9),
                        ),
                      ),
                    );
                  } else if (index == 2) {
                    return ListTile(
                      leading: Icon(Icons.people),
                      title: Text(
                        'Women Cell',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        '181',
                        style: TextStyle(fontSize: 22),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _makePhoneCall('181');
                        },
                        child: Icon(
                          Icons.call,
                          color: Color(0xff068DA9),
                        ),
                      ),
                    );
                  } else if (index == 3) {
                    return ListTile(
                      leading: Icon(Icons.child_care),
                      title: Text(
                        'Child Line',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        '1098',
                        style: TextStyle(fontSize: 22),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _makePhoneCall('1098');
                        },
                        child: Icon(
                          Icons.call,
                          color: Color(0xff068DA9),
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      // Handle any other case or return an empty container if needed
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
