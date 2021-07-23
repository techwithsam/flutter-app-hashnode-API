import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/style/colors.dart';
import 'package:hashnode/style/style.dart';

class BlogList extends StatelessWidget {
  final String? img;
  final String? title;
  final String? uname;
  final int? commt;
  final String? name;
  const BlogList(
      {Key? key,
      @required this.commt,
      @required this.img,
      @required this.title,
      @required this.name,
      @required this.uname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 330,
      margin: EdgeInsets.only(bottom: 14, left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[500]!.withOpacity(1.0),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          img == ''
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/noimg.png'),
                    ),
                  ),
                )
              : getImg(context),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 0, top: 4),
            child: Column(
              children: <Widget>[
                Text('$title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle().titleStyle),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: FittedBox(
                          child: Row(
                            children: [
                              Text(
                                '$name',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColor().mainColor,
                                ),
                              ),
                              Text(
                                '  @$uname',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColor().primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(Icons.comment_outlined),
                                onPressed: () {}),
                            Text('$commt',
                                style: GoogleFonts.alice(
                                    color: AppColor().mainColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getImg(BuildContext context) {
    return Image.network(
      '$img',
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 210,
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
          width: MediaQuery.of(context).size.width,
          height: 210,
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
