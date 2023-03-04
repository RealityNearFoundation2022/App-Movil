import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConfigurationScreen extends StatefulWidget {
  //Variables
  static String routeName = "/configScreen";
  const ConfigurationScreen({Key key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  String version = '';

  getVersion() async {
    var x = await getPreference('current_version');
    return x;
  }

  @override
  void initState() {
    super.initState();
    getVersion().then((result) async {
      if (mounted) {
        setState(() {
          version = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalApppBar(context, 'About'),
      backgroundColor: Colors.white,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (() {
              launchUrlString(
                  "https://www.privacypolicies.com/live/ad5f099b-84a2-474d-8e1b-ffbd8f0be04a",
                  mode: LaunchMode.externalApplication);
            }),
            child: textAndIcon(
                S.current.PoliticaDePrivacidad, Icons.privacy_tip_rounded),
          ),
          //Version of app
          textAndIcon('Versión: $version', Icons.verified_sharp),
        ],
      ),
    );
  }

  Widget textAndIcon(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.sourceSansPro(
              color: greenPrimary,
              fontSize: getResponsiveText(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          icon != null
              ? Icon(
                  icon,
                  size: getResponsiveText(context, 30),
                  color: greenPrimary,
                )
              : const SizedBox(
                  width: 15,
                ),
        ],
      ),
    );
  }
}