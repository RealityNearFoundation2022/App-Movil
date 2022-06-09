import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildBid(
  String title,
  int price,
  String author,
  String authorImg,
  String nftImg,
  Color defaultFontColor,
  bool isDarkMode,
  Size size,
) {
  double width = size.width * 0.7;
  double height = size.height * 0.2;
  return Padding(
    padding: EdgeInsets.only(left: size.width * 0.055),
    child: SizedBox(
      width: width,
      height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      nftImg,
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.05)
                                : Colors.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height * 0.14,
                        width: width * 0.26,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Align(
                          child: Text(
                            "02:30:02",
                            style: GoogleFonts.inconsolata(
                              color: Colors.white,
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height * 0.14,
                        width: width * 0.26,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Align(
                          child: Text(
                            "Surco",
                            style: GoogleFonts.inconsolata(
                              color: Colors.white,
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
            ),
            child: SizedBox(
              width: width,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: defaultFontColor,
                  fontSize: width * 0.075,
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
