import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/news_details_page.dart';

class NewsWidget extends StatelessWidget {
  final NewsModel news;
  const NewsWidget({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.9;
    double height = size.height * 0.25;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 10, top: 5),
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
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  alignment: Alignment.center,
                  height: height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    news.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
