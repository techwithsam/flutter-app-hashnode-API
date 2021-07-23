import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/style/colors.dart';

class NoInternet extends StatelessWidget {
  final void Function() callBack;
  const NoInternet({Key key, @required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor().mainColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 4),
            Icon(
              Icons.signal_wifi_off,
              size: 40,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text('No Internet connection Please retry.',
                style: GoogleFonts.openSans(
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 22),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              onPressed: () => callBack(),
              child: Text(
                'Refresh'.toUpperCase(),
              ),
              color: AppColor().mainColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
