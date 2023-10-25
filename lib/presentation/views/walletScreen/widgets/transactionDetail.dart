import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:near_flutter/near_flutter.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';

class TransferDetail extends StatefulWidget {
  TransferDetail({Key key}) : super(key: key);
  static String routeName = "/transferDeatil";

  @override
  State<TransferDetail> createState() => _TransferDetailState();
}

class _TransferDetailState extends State<TransferDetail> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _amountController = TextEditingController();
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              S.current.Transferir + ' Realities',
              style: GoogleFonts.sourceSansPro(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: greenPrimary,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: greenPrimary, size: 35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(args['img']),
                ),
              ),
              Text(
                args['name'],
                style: GoogleFonts.sourceSansPro(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: txtPrimary,
                ),
              ),
              Text(
                args['walletId'],
                style: GoogleFonts.sourceSansPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: txtPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ver perfil',
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: txtPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/iconLogo.png"),
                    radius: 20,
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: "1452.64451",
                        hintStyle: GoogleFonts.sourceSansPro(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: txtPrimary.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: txtPrimary.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Disponible: 1543.1234',
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: txtPrimary,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(greenPrimary),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10))),
                  onPressed: () async {
                    // var endUrl = await RestApiProvider()
                    //     .transferRestApiProvider(
                    //         'eduperaltas.testnet',
                    //         'eduperaltas98.testnet' /*args['walletId']*/,
                    //         _amountController.text);
                    // String urlToLaunch = endUrl.toString();
                    // if (urlToLaunch.contains('https')) {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) =>
                    //           NearUrlLauncher(initialUrl: urlToLaunch)));
                    // }
                  },
                  child: Text('Enviar',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)))
            ],
          ),
        ));
  }
}
