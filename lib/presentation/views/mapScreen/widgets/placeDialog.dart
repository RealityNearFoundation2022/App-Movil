import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/usecases/cuppons/assignCuponToUser.dart';
import 'package:reality_near/generated/l10n.dart';

class PlaceDialog extends StatefulWidget {
  const PlaceDialog({Key key}) : super(key: key);

  @override
  State<PlaceDialog> createState() => _PermisosDialogState();
}

class _PermisosDialogState extends State<PlaceDialog> {
  bool loading = false;
  bool error = false;
  _AssignCupon(String cuponId) async {
    setState(() {
      loading = true;
    });
    await AssignCuponUseCase(cuponId).call().then((value) {
      value.fold((l) {
        setState(() {
          error = true;
          loading = false;
        });
      }, (r) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushNamed('/qrViewScreen');
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: ScreenWH(context).height * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: error ?  errorView()
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aniversario asociación Luta Livre Perú',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: greenPrimary),
              ),
              Container(
                height: ScreenWH(context).height * 0.28,
                width: ScreenWH(context).width * 0.6,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imgs/lutaLivreAR.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => _AssignCupon('9'),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(greenPrimary),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 50)),
                  ),
                  child: loading ?  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                      height: ScreenWH(context).height * 0.03,
                      width: ScreenWH(context).width * 0.05,
                      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 3,))
                      : Text(
                    S.current.Canjear,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  errorView(){
    return Column(
      children: [
        const SizedBox(height: 30),
        //x en circulo rojo
         CircleAvatar(
          radius: ScreenWH(context).width * 0.15,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: ScreenWH(context).width * 0.25,
          ),
        ),
        const SizedBox(height: 30),

        Text(
          'Error al canjear cupón',
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: greenPrimary),
        ),
        const SizedBox(height: 10),
        Text(
          'Error al canjear cupón',
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: txtPrimary),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop,
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(greenPrimary),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 50)),
            ),
            child: Text(
              S.current.Volver,
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
