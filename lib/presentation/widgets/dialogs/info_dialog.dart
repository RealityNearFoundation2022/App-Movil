import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/widgets/buttons/default_button.dart';

class InfoDialog extends StatelessWidget {
  final String title, message, image;
  final Function onPressed;
  Widget icon;
  bool closeOption = false;
  InfoDialog(
      {Key key,
      this.title,
      this.message,
      this.icon,
      this.onPressed,
      this.image,
      this.closeOption})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                icon ?? Container(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: txtPrimary),
                ),
                const SizedBox(
                  height: 10,
                ),
                image != null
                    ? Image.network(
                        image,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.6,
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    message,
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: txtPrimary),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                      onPressed: onPressed,
                      label: 'Continuar',
                      // colorDefault: greenPrimary,
                      textColor: Colors.white,

                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    closeOption ?? false
                        ? const SizedBox(
                            width: 15,
                          )
                        : const SizedBox(),
                    closeOption ?? false
                        ? AppButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: 'Cancelar',
                            colorDefault: Colors.grey,
                            textColor: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.5,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
