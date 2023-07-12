// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';

class UpdateDialog extends StatefulWidget {
  final bool requiredUpdate;
  const UpdateDialog({
    Key key,
    this.requiredUpdate,
  }) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  @override
  void initState() {
    super.initState();
  }

  goToUpdate() {
    goToUrl(Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=org.realitynear.reality_near"
        : "https://apps.apple.com/pe/app/reality-near/id1645021476?l=en");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: const EdgeInsets.symmetric(vertical: 10),
      child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [body(), buttonUpdateOrLater()],
            ),
          )),
    );
  }

  title(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'letra_Telefonica_bold',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: greenPrimary)),
    );
  }

  body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/imgs/MonstruoSaludando.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.3),
          const SizedBox(height: 20),
          const Text('¡Hay una actualización disponible!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'letra_Telefonica_regular',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(height: 20),
          Text(
              "Para disfrutar de la mejor experiencia de Reality Near, es necesario que actualices la aplicación.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'letra_Telefonica_regular',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: txtGrey)),
        ],
      ),
    );
  }

  buttonUpdateOrLater() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                goToUpdate();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(greenPrimary),
                elevation: MaterialStateProperty.all(1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.7, 35)),
              ),
              child: const Text(
                "Actualizar ahora",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'letra_Telefonica_bold',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            widget.requiredUpdate
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Recuerdamelo más tarde",
                      style: TextStyle(
                          color: txtGrey.withOpacity(0.6),
                          fontFamily: 'letra_Telefonica_regular',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
            const SizedBox(
              height: 5,
            )
          ],
        ));
  }
}
