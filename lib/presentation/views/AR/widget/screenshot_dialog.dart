import "dart:typed_data";

import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:reality_near/core/framework/colors.dart";
import "package:reality_near/core/framework/globals.dart";
import "package:reality_near/presentation/widgets/dialogs/info_dialog.dart";

class ScreenshotDialog extends StatefulWidget {
  final Uint8List unityScreenshot;
  final Function xFunction, saveFunction, shareFunction;
  final GlobalKey globalKey;
  const ScreenshotDialog(
      {Key key,
      this.globalKey,
      this.unityScreenshot,
      this.xFunction,
      this.saveFunction,
      this.shareFunction})
      : super(key: key);

  @override
  State<ScreenshotDialog> createState() => _ScreenshotDialogState();
}

class _ScreenshotDialogState extends State<ScreenshotDialog> {
  bool loadFunction = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: ScreenWH(context).width * 0.8,
            height: ScreenWH(context).height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                RepaintBoundary(
                  key: widget.globalKey,
                  child: Stack(
                    children: [
                      Container(
                        width: ScreenWH(context).width * 0.8,
                        height: ScreenWH(context).height * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: MemoryImage(widget.unityScreenshot),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/imgs/Logo_sin_fondo.png",
                            width: ScreenWH(context).width * 0.3,
                            height: ScreenWH(context).height * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      widget.xFunction();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.close_rounded,
                        color: greenPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 15,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.15,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: loadFunction
                          ? Container(
                              alignment: Alignment.center,
                              width: ScreenWH(context).width * 0.8,
                              height: ScreenWH(context).width * 0.15,
                              child: LoadingAnimationWidget.dotsTriangle(
                                size: ScreenWH(context).width * 0.15,
                                color: greenPrimary,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Icons to share and save
                                IconButton(
                                  icon: Icon(
                                    Icons.save_alt,
                                    color: greenPrimary,
                                    size: ScreenWH(context).width * 0.1,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loadFunction = true;
                                    });
                                    widget.saveFunction();
                                    setState(() {
                                      loadFunction = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return InfoDialog(
                                              title: "¡Guardado!",
                                              message:
                                                  "La imagen se ha guardado en tu galería",
                                              icon: SizedBox(
                                                  child: Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: greenPrimary,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                              )),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              });
                                        });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.ios_share,
                                    color: greenPrimary,
                                    size: ScreenWH(context).width * 0.1,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loadFunction = true;
                                    });
                                    widget.shareFunction();
                                    setState(() {
                                      loadFunction = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                    )),
              ],
            ),
          ),
        ));
  }
}
