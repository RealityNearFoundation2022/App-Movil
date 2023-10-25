import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/social/widget/social_dialog.dart';

class SocialGrid extends StatefulWidget {
  final int numElements;
  const SocialGrid({Key key, this.numElements}) : super(key: key);

  @override
  State<SocialGrid> createState() => _SocialGridState();
}

class _SocialGridState extends State<SocialGrid>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  AnimationController _animationController;
  Animation _colorBackgroundPhoto;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _colorBackgroundPhoto = ColorTween(
            begin: Colors.transparent, end: greenPrimary.withOpacity(0.6))
        .animate(_animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //grid 2x2
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: GridView.builder(
            itemCount: widget.numElements,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.35),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              return socialWidget(index);
            }));
  }

  bool like = false;
  socialWidget(int id) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
              animation: _colorBackgroundPhoto,
              builder: (context, child) {
                return Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        _animationController.forward();
                        Future.delayed(const Duration(seconds: 1), () {
                          _animationController.reverse();
                        });
                      },
                      onTap: () {
                        //show dialog
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: ((context) => const SocialDetailDialog()));
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  "assets/imgs/imgAlfaTest.png"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  _colorBackgroundPhoto.value,
                                  BlendMode.srcOver),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _animationController.isCompleted
                              ? Icon(FontAwesomeIcons.solidHeart,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.height *
                                      0.27 /
                                      8)
                              : const SizedBox()),
                    ),
                    _colorBackgroundPhoto.isCompleted
                        ? const SizedBox()
                        : Positioned(
                            bottom: 5,
                            right: 0,
                            child: Column(
                              children: [
                                IconButton(
                                  constraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.27 /
                                            7,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      like = !like;
                                    });
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      setState(() {
                                        like = !like;
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    like
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: greenPrimary,
                                    size: MediaQuery.of(context).size.height *
                                        0.27 /
                                        9,
                                  ),
                                ),
                                Text(
                                  "${id + 100}",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              }),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: greenPrimary.withOpacity(0.2),
                child: loading
                    ? LoadingAnimationWidget.dotsTriangle(
                        color: greenPrimary,
                        size: ScreenWH(context).width * 0.05,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/gift/MEN_SELECTED.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Name',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Hace 1 hora',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: txtGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
