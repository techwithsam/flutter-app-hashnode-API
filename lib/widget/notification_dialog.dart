import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDialog extends StatefulWidget {
  final String? title;
  final String? body;
  final String? img;
  final String? btnName;
  final String? btnAction;
  NotificationDialog(
      {Key? key,
      required this.title,
      required this.body,
      required this.img,
      required this.btnName,
      required this.btnAction})
      : super(key: key);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
              title: Center(
                child: Text(
                  '${widget.title}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: AppColor().mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              subtitle: Text(
                '${widget.body}',
                style: GoogleFonts.poppins(fontSize: 14),
              )),
          getImg(context),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            if (widget.btnName == 'Read Article') {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlogViews(
                            title: 'Tech With Sam',
                            urli: '${widget.btnAction}',
                          )));
            } else if (widget.btnName == 'Close') {
              Navigator.of(context).pop();
            } else {
              launch('${widget.btnAction}');
            }
          },
          child: Text(
            '${widget.btnName}',
            style: GoogleFonts.poppins(color: AppColor().mainColor),
          ),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
            shadowColor: AppColor().mainColor,
            primary: AppColor().mainColor,
          ),
        ),
      ],
    );
  }

  getImg(BuildContext context) {
    return Image.network(
      '${widget.img}',
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return Container(
          //width: MediaQuery.of(context).size.width,
          // height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          //width: MediaQuery.of(context).size.width,
          //height: 210,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.1,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!.toInt()
                  : null,
            ),
          ),
        );
      },
    );
  }
}
