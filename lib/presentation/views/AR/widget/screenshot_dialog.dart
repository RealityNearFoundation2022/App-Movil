import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:path_provider/path_provider.dart";
import "package:reality_near/core/framework/colors.dart";
import "package:reality_near/core/framework/globals.dart";
import "package:reality_near/generated/l10n.dart";
import "package:reality_near/presentation/widgets/dialogs/info_dialog.dart";
import "package:share_plus/share_plus.dart";
import 'dart:ui' as ui;

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
  Uint8List _screenshotCompleted;
  bool successSave = false;
  Future<void> _saveImageToGallery(Uint8List uint8List) async {
    // Guarda la imagen en la galería y obten el path
    var path = await ImageGallerySaver.saveImage(uint8List,
        isReturnImagePathOfIOS: true, quality: 100);
  }

  Future<Uint8List> addLogoToImage(Uint8List imageBytes) async {
    // Cargar la imagen del logo desde los assets
    ByteData logoData = await rootBundle.load('assets/imgs/Logo_sin_fondo.png');
    Uint8List logoBytes = logoData.buffer.asUint8List();

    // Obtener el tamaño del dispositivo
    double deviceHeight = MediaQuery.of(context).size.height;
    double devicePaddingTop = MediaQuery.of(context).padding.top;

    // Calcular el margen superior para el logo
    double logoMarginTop = devicePaddingTop + (deviceHeight * 0.13);

    // Decodificar las imágenes
    ui.Codec imageCodec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo imageFrame = await imageCodec.getNextFrame();
    ui.Image image = imageFrame.image;
    ui.Codec logoCodec = await ui.instantiateImageCodec(logoBytes);
    ui.FrameInfo logoFrame = await logoCodec.getNextFrame();
    ui.Image logo = logoFrame.image;

    // Calcular el tamaño deseado del logo
    double logoSize = 290.0;

    // Calcular la posición del logo
    double logoX = (image.width - logoSize) / 2; // Centrar horizontalmente
    double logoY = logoMarginTop;

    // Crear un lienzo para dibujar las imágenes
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Dibujar la imagen original
    canvas.drawImage(image, Offset.zero, Paint());

    // Dibujar el logo en la posición deseada con el tamaño especificado
    canvas.drawImageRect(
        logo,
        Rect.fromLTWH(0, 0, logo.width.toDouble(), logo.height.toDouble()),
        Rect.fromLTWH(logoX, logoY, logoSize, logoSize),
        Paint());

    // Finalizar el dibujo
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return Uint8List.view(pngBytes.buffer);
  }

  Future<void> _capturePng() async {
    // Captura la imagen del widget
    ui.Image image = await (widget.globalKey.currentContext.findRenderObject()
            as RenderRepaintBoundary)
        .toImage(pixelRatio: 3.0);

    // Recorta y escala la imagen
    ui.Image croppedImage = await cropAndScaleImage(image);

    // Convierte la imagen en bytes
    ByteData byteData =
        await croppedImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
    setState(() {
      _screenshotCompleted = uint8list;
    });
  }

  // Función para recortar y escalar la imagen
  Future<ui.Image> cropAndScaleImage(ui.Image image) async {
    // Obtenemos el tamaño de la imagen original
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());

    // Definimos el tamaño objetivo de la imagen
    const targetSize = Size(1080, 1920);

    // Calculamos la proporción de aspecto de la imagen original
    final aspectRatio = imageSize.width / imageSize.height;

    // Calculamos la proporción de aspecto del tamaño objetivo
    // final targetAspectRatio = targetSize.width / targetSize.height;
    const targetAspectRatio = 9 / 16;

    // Calculamos el rectángulo de recorte para la imagen original
    Rect cropRect;
    if (aspectRatio > targetAspectRatio) {
      final height = imageSize.width / targetAspectRatio;
      cropRect = Rect.fromLTWH(
          0, (imageSize.height - height) / 2, imageSize.width, height);
    } else {
      final width = imageSize.height * targetAspectRatio;
      cropRect = Rect.fromLTWH(
          (imageSize.width - width) / 2, 0, width, imageSize.height);
    }

    // Creamos una nueva imagen recortada y escalada
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()
      ..filterQuality = ui.FilterQuality.high
      ..color = Colors.black; // establecer el color de fondo a negro
    canvas.drawRect(Offset.zero & targetSize, paint); // dibujar el fondo negro
    canvas.drawImageRect(image, cropRect, Offset.zero & targetSize, paint);
    final croppedImage = await pictureRecorder
        .endRecording()
        .toImage(targetSize.width.toInt(), targetSize.height.toInt());

    return croppedImage;
  }

  Future<void> _shareImage(Uint8List imageBytes) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String fileName =
          "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";
      File file = File('${tempDir.path}/$fileName');
      file.writeAsBytesSync(imageBytes);

      await Share.shareXFiles([XFile(file.path)]);
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                width: ScreenWH(context).width,
                height: ScreenWH(context).height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RepaintBoundary(
                  key: widget.globalKey,
                  child: Stack(
                    children: [
                      Container(
                        width: ScreenWH(context).width,
                        height: ScreenWH(context).height,
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
                          width: MediaQuery.of(context).size.width,
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
              ),
              Positioned(
                bottom: 15, // Alineado en la parte inferior
                left: 10,
                right: 10,
                child: Padding(
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
                                _capturePng().then((value) {
                                  _saveImageToGallery(_screenshotCompleted)
                                      .then((value) => {
                                            setState(() {
                                              loadFunction = false;
                                            }),
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return InfoDialog(
                                                      title: "¡Guardado!",
                                                      message:
                                                          "La imagen se ha guardado en tu galería",
                                                      icon: SizedBox(
                                                          child: Icon(
                                                        Icons
                                                            .check_circle_outline_rounded,
                                                        color: greenPrimary,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                      )),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      });
                                                }),
                                          });
                                });
                              },
                            ),
                            successSave
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: greenPrimary,
                                        width: 2,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: ScreenWH(context).width * 0.3,
                                    height: ScreenWH(context).width * 0.15,
                                    child: Text(
                                      S.current.guardadoCorrectamente,
                                      style: GoogleFonts.sourceSansPro(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
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
                                _capturePng().then((value) {
                                  _shareImage(_screenshotCompleted)
                                      .then((value) => {
                                            setState(() {
                                              loadFunction = false;
                                            }),
                                          });
                                });
                              },
                            ),
                          ],
                        ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                          offset: const Offset(0, 3),
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
            ],
          ),
        ));
  }
}
