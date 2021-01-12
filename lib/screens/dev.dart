import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDev extends StatefulWidget {
  ContactDev({Key key}) : super(key: key);

  @override
  _ContactDevState createState() => _ContactDevState();
}

class _ContactDevState extends State<ContactDev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer',
            style: GoogleFonts.poppins(color: AppColor().mainColor)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'This app is powered by ',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                    text: 'Hashnode API',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://api.hashnode.com/');
                      },
                    style: GoogleFonts.poppins(
                      color: AppColor().mainColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double,
                    )),
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/user.png'),
                        backgroundColor: Colors.transparent,
                        radius: 68,
                      ),
                      Text('  Samuel Adekunle',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          )),
                      Text('  Software Engineer'),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch('https://twitter.com/iamsamadekunle');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/twitter.jpg'),
                            backgroundColor: Colors.transparent,
                            radius: 12,
                          ),
                          Text(
                            'Twitter',
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('https://github.com/acctgen1');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/git.png'),
                            backgroundColor: Colors.transparent,
                            radius: 12,
                          ),
                          Text(
                            'GitHub',
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('https://acctgen1.medium.com');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/medium.png'),
                            backgroundColor: Colors.transparent,
                            radius: 12,
                          ),
                          Text(
                            'Medium',
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('https://acctgen1.hashnode.dev');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/hash.jpg'),
                            backgroundColor: Colors.transparent,
                            radius: 12,
                          ),
                          Text(
                            'Hashnode',
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('https://www.linkedin.com/in/acctgen1/');
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/link.png'),
                            backgroundColor: Colors.transparent,
                            radius: 12,
                          ),
                          Text(
                            'LinkedIn',
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
