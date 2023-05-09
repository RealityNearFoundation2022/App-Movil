import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/domain/usecases/news/get_news.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/news_details_page.dart';

class SectionCarousel extends StatefulWidget {
  const SectionCarousel({Key key}) : super(key: key);

  @override
  State<SectionCarousel> createState() => SectionCarouselState();
}

class SectionCarouselState extends State<SectionCarousel> {
  bool _isLoading = true;
  List<NewsModel> lstCarrousel = [];

  _getCarrousel() async {
    await GetNews().call().then((value) {
      lstCarrousel =
          value.where((element) => element.planners == 'Banners').toList();
      _isLoading = false;
    });
  }

  PageController _pageController;
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    _getCarrousel().then((result) async {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return lstCarrousel.isEmpty && !_isLoading
        ? const SizedBox()
        : Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _isLoading
                ? LoadingAnimationWidget.dotsTriangle(
                    color: greenPrimary,
                    size: MediaQuery.of(context).size.height * 0.15,
                  )
                : ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: lstCarrousel.length,
                          onPageChanged: (int index) {
                            setState(() {
                              _position = index;
                            });
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return imageSlider(index);
                          },
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 25),
                            child: AnimatedPageIndicatorFb1(
                              currentPage: _position,
                              numPages: lstCarrousel.length,
                              gradient: const LinearGradient(
                                  colors: [greenPrimary, greenPrimary]),
                              activeGradient: const LinearGradient(
                                  colors: [greenPrimary, greenPrimary]),
                            )),
                      ],
                    ),
                  ),
          );
  }

  Widget imageSlider(int position) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return Center(
          child: widget,
        );
      },
      child: CarouselCard(article: lstCarrousel[position]),
    );
  }
}

class CarouselCard extends StatelessWidget {
  final NewsModel article;
  // ignore: prefer_typing_uninitialized_variables
  const CarouselCard({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(news: article),
          ),
        );
      },
      child: Stack(
        children: [
          //Image with opacity
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: CachedNetworkImage(
              imageUrl: API_REALITY_NEAR_IMGs + article.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedPageIndicatorFb1 extends StatelessWidget {
  const AnimatedPageIndicatorFb1(
      {Key key,
      this.currentPage,
      this.numPages,
      this.dotHeight = 10,
      this.activeDotHeight = 10,
      this.dotWidth = 10,
      this.activeDotWidth = 20,
      this.gradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
      this.activeGradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)])})
      : super(key: key);

  final int
      currentPage; //the index of the active dot, i.e. the index of the page you're on
  final int
      numPages; //the total number of dots, i.e. the number of pages your displaying

  final double dotWidth; //the width of all non-active dots
  final double activeDotWidth; //the width of the active dot
  final double activeDotHeight; //the height of the active dot
  final double dotHeight; //the height of all dots
  final Gradient gradient; //the gradient of all non-active dots
  final Gradient activeGradient; //the gradient of the active dot

  double _calcRowSize() {
    //Calculates the size of the outer row that creates spacing that is equivalent to the width of a dot
    const int widthFactor = 2; //assuming spacing is equal to the width of a dot
    return (dotWidth * numPages * widthFactor) + activeDotWidth - dotWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _calcRowSize(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          numPages,
          (index) => AnimatedPageIndicatorDot(
            isActive: currentPage == index,
            gradient: gradient,
            activeGradient: activeGradient,
            activeWidth: activeDotWidth,
            activeHeight: activeDotHeight,
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicatorDot extends StatelessWidget {
  const AnimatedPageIndicatorDot(
      {Key key,
      this.isActive,
      this.height = 10,
      this.width = 10,
      this.activeWidth = 20,
      this.activeHeight = 10,
      this.gradient,
      this.activeGradient})
      : super(key: key);

  final bool isActive;
  final double height;
  final double width;
  final double activeWidth;
  final double activeHeight;
  final Gradient gradient;
  final Gradient activeGradient;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isActive ? activeWidth : width,
      height: isActive ? activeHeight : height,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          gradient: isActive ? activeGradient : gradient,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
    );
  }
}
