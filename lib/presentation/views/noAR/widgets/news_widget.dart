import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/presentation/views/noAR/widgets/news_details_page.dart';

class NewsWidget extends StatelessWidget {
  final NewsModel news;
  const NewsWidget({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.7;
    double height = size.height * 0.2;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: size.width * 0.055),
      height: height,
      width: width,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(news: news),
            ),
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                API_REALITY_NEAR_IMGs + news.image,
                fit: BoxFit.fill,
                width: width,
                height: height,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            FittedBox(
              child: Container(
                alignment: Alignment.topLeft,
                height: height * 0.14,
                // width: width * 0.7,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  news.title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
