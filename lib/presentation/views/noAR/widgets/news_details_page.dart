import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;
  const NewsDetailPage({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: ScreenWH(context).width,
                height: ScreenWH(context).height * 0.35,
                child: ClipRRect(
                  child: Image.network(
                    API_REALITY_NEAR_IMGs + news.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceSansPro(
                        color: greenPrimary,
                        fontSize: ScreenWH(context).width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "by ${news.planners ?? 'Reality Near Foundation'}",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: ScreenWH(context).width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: txtPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: news.articles.length,
                itemBuilder: (context, index) {
                  var article = news.articles[index];
                  return articleContent(article.data, article.image, context);
                },
              ),
              SizedBox(
                height: ScreenWH(context).height * 0.05,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _footter(context),
    );
  }

  articleContent(String content, String img, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            textAlign: TextAlign.left,
            style: GoogleFonts.sourceSansPro(
                fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                API_REALITY_NEAR_IMGs + img,
                width: ScreenWH(context).width * 0.8,
                height: ScreenWH(context).height * 0.2,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _footter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: greenPrimary, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Respond to button press
          //   },
          //   style: ButtonStyle(
          //     backgroundColor:
          //     MaterialStateProperty.all<Color>(greenPrimary),
          //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20.0))),
          //     padding: MaterialStateProperty.all<EdgeInsets>(
          //         const EdgeInsets.symmetric(horizontal: 30)),
          //   ),
          //   child: Text(
          //     "!Vamos¡",
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.sourceSansPro(
          //       color: Colors.white,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.share_outlined,
          //       color: icongrey, size: 35),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ],
      ),
    );
  }
}
