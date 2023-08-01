import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/fb_news_model.dart';

class NewsDetailPage extends StatelessWidget {
  // final NewsModel news;
  final fsNewsModel news;
  const NewsDetailPage({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            SizedBox(
              width: ScreenWH(context).width,
              height: ScreenWH(context).width,
              child: ClipRRect(
                child: Image.network(
                  // API_REALITY_NEAR_IMGs + news.img,
                  news.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         news.title,
            //         textAlign: TextAlign.left,
            //         style: GoogleFonts.sourceSansPro(
            //           color: greenPrimary,
            //           fontSize: ScreenWH(context).width * 0.07,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       // Align(
            //       //   alignment: Alignment.centerLeft,
            //       //   child: Text(
            //       //     news.planners ?? 'Reality Near Foundation',
            //       //     textAlign: TextAlign.start,
            //       //     style: GoogleFonts.sourceSansPro(
            //       //         fontSize: ScreenWH(context).width * 0.04,
            //       //         fontWeight: FontWeight.bold,
            //       //         color: txtPrimary),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Html(
                data: news.content,
                onLinkTap: (url, attributes, element) => goToUrl(url),
                style: {
                  'p': Style(fontSize: FontSize(18)),
                },
              ),
            ),
            // ListView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
            //   itemCount: news.articles.length,
            //   itemBuilder: (context, index) {
            //     var article = news.articles[index];
            //     return articleContent(article.data, article.image, context);
            //   },
            // ),
            SizedBox(
              height: ScreenWH(context).height * 0.12,
            ),
          ],
        ),
      ),
      bottomSheet: _footter(context),
    );
  }

  // articleContent(String content, String img, BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           content,
  //           textAlign: TextAlign.left,
  //           style: GoogleFonts.sourceSansPro(
  //               fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         // Center(
  //         //   child: ClipRRect(
  //         //     borderRadius: const BorderRadius.all(Radius.circular(20)),
  //         //     child: Image.network(
  //         //       API_REALITY_NEAR_IMGs + img,
  //         //       width: ScreenWH(context).width * 0.8,
  //         //       // height: ScreenWH(context).height * 0.4,
  //         //       fit: BoxFit.contain,
  //         //     ),
  //         //   ),
  //         // ),
  //         // const SizedBox(
  //         //   height: 20,
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  _footter(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
      // margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: MediaQuery.of(context).size.height * 0.055,
            icon:
                const Icon(Icons.arrow_back_ios, color: greenPrimary, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
