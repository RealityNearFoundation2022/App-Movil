// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login with wallet`
  String get btnLogWallet {
    return Intl.message(
      'Login with wallet',
      name: 'btnLogWallet',
      desc: '',
      args: [],
    );
  }

  /// `Login with email`
  String get btnLogEmail {
    return Intl.message(
      'Login with email',
      name: 'btnLogEmail',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a wallet yet? `
  String get noTienesUna {
    return Intl.message(
      'You don\'t have a wallet yet? ',
      name: 'noTienesUna',
      desc: '',
      args: [],
    );
  }

  /// `Create one`
  String get CreaUna {
    return Intl.message(
      'Create one',
      name: 'CreaUna',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get O {
    return Intl.message(
      'Or',
      name: 'O',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Registrate {
    return Intl.message(
      'Register',
      name: 'Registrate',
      desc: '',
      args: [],
    );
  }

  /// `Wallet required`
  String get WalletOblig {
    return Intl.message(
      'Wallet required',
      name: 'WalletOblig',
      desc: '',
      args: [],
    );
  }

  /// `Email required`
  String get EmailOblig {
    return Intl.message(
      'Email required',
      name: 'EmailOblig',
      desc: '',
      args: [],
    );
  }

  /// `Password required`
  String get PasswordOblig {
    return Intl.message(
      'Password required',
      name: 'PasswordOblig',
      desc: '',
      args: [],
    );
  }

  /// `Login failed, please try again`
  String get failLogin {
    return Intl.message(
      'Login failed, please try again',
      name: 'failLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Ingresar {
    return Intl.message(
      'Login',
      name: 'Ingresar',
      desc: '',
      args: [],
    );
  }

  /// `Sync your Near Wallet`
  String get SyncWallet {
    return Intl.message(
      'Sync your Near Wallet',
      name: 'SyncWallet',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Password Confirmation`
  String get PasswordConf {
    return Intl.message(
      'Password Confirmation',
      name: 'PasswordConf',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get Camara {
    return Intl.message(
      'Camera',
      name: 'Camara',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get Map {
    return Intl.message(
      'Map',
      name: 'Map',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editar {
    return Intl.message(
      'Edit',
      name: 'editar',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get Menu {
    return Intl.message(
      'Menu',
      name: 'Menu',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Omitir {
    return Intl.message(
      'Skip',
      name: 'Omitir',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Siguiente {
    return Intl.message(
      'Next',
      name: 'Siguiente',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Bienvenido {
    return Intl.message(
      'Welcome',
      name: 'Bienvenido',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get Transferir {
    return Intl.message(
      'Transfer',
      name: 'Transferir',
      desc: '',
      args: [],
    );
  }

  /// `Loading ...`
  String get Cargando {
    return Intl.message(
      'Loading ...',
      name: 'Cargando',
      desc: '',
      args: [],
    );
  }

  /// `Receive`
  String get Recibir {
    return Intl.message(
      'Receive',
      name: 'Recibir',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get Eventos {
    return Intl.message(
      'Events',
      name: 'Eventos',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get Novedades {
    return Intl.message(
      'News',
      name: 'Novedades',
      desc: '',
      args: [],
    );
  }

  /// `New Nft's`
  String get NuevosNFts {
    return Intl.message(
      'New Nft\'s',
      name: 'NuevosNFts',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get Vertodos {
    return Intl.message(
      'See all',
      name: 'Vertodos',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get Amigos {
    return Intl.message(
      'Friends',
      name: 'Amigos',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get Configuracion {
    return Intl.message(
      'Configuration',
      name: 'Configuracion',
      desc: '',
      args: [],
    );
  }

  /// `Permissions`
  String get Permisos {
    return Intl.message(
      'Permissions',
      name: 'Permisos',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get Informacion {
    return Intl.message(
      'Information',
      name: 'Informacion',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get Cuenta {
    return Intl.message(
      'Account',
      name: 'Cuenta',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get Usuario {
    return Intl.message(
      'User',
      name: 'Usuario',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get Wallet {
    return Intl.message(
      'Wallet',
      name: 'Wallet',
      desc: '',
      args: [],
    );
  }

  /// `Show Avatar on Map`
  String get MostrarAvatarMapa {
    return Intl.message(
      'Show Avatar on Map',
      name: 'MostrarAvatarMapa',
      desc: '',
      args: [],
    );
  }

  /// `Microphone`
  String get Microfono {
    return Intl.message(
      'Microphone',
      name: 'Microfono',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get Ubicacion {
    return Intl.message(
      'Location',
      name: 'Ubicacion',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notificaciones {
    return Intl.message(
      'Notifications',
      name: 'Notificaciones',
      desc: '',
      args: [],
    );
  }

  /// `Link your email`
  String get VincularEmail {
    return Intl.message(
      'Link your email',
      name: 'VincularEmail',
      desc: '',
      args: [],
    );
  }

  /// `Movements`
  String get Movimientos {
    return Intl.message(
      'Movements',
      name: 'Movimientos',
      desc: '',
      args: [],
    );
  }

  /// `Search movements ...`
  String get BuscarMovimientos {
    return Intl.message(
      'Search movements ...',
      name: 'BuscarMovimientos',
      desc: '',
      args: [],
    );
  }

  /// `Search NFT's...`
  String get BuscarNFTs {
    return Intl.message(
      'Search NFT\'s...',
      name: 'BuscarNFTs',
      desc: '',
      args: [],
    );
  }

  /// `Search chat ...`
  String get BuscarChat {
    return Intl.message(
      'Search chat ...',
      name: 'BuscarChat',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get Pendientes {
    return Intl.message(
      'Pending',
      name: 'Pendientes',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get Solicitudes {
    return Intl.message(
      'Requests',
      name: 'Solicitudes',
      desc: '',
      args: [],
    );
  }

  /// `Search user ...`
  String get BuscarUsuario {
    return Intl.message(
      'Search user ...',
      name: 'BuscarUsuario',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get CancelarSolicitud {
    return Intl.message(
      'Cancel request',
      name: 'CancelarSolicitud',
      desc: '',
      args: [],
    );
  }

  /// `Send request`
  String get EnviarSolicitud {
    return Intl.message(
      'Send request',
      name: 'EnviarSolicitud',
      desc: '',
      args: [],
    );
  }

  /// `{amigos} friends in common`
  String amigosEnComun(Object amigos) {
    return Intl.message(
      '$amigos friends in common',
      name: 'amigosEnComun',
      desc: '',
      args: [amigos],
    );
  }

  /// `Accept`
  String get Aceptar {
    return Intl.message(
      'Accept',
      name: 'Aceptar',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get Rechazar {
    return Intl.message(
      'Reject',
      name: 'Rechazar',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get InfoDelContacto {
    return Intl.message(
      'Contact info',
      name: 'InfoDelContacto',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get Disponible {
    return Intl.message(
      'online',
      name: 'Disponible',
      desc: '',
      args: [],
    );
  }

  /// `disconnected`
  String get Desconectado {
    return Intl.message(
      'disconnected',
      name: 'Desconectado',
      desc: '',
      args: [],
    );
  }

  /// `Empty chat`
  String get VaciarChat {
    return Intl.message(
      'Empty chat',
      name: 'VaciarChat',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get Bloquear {
    return Intl.message(
      'Block',
      name: 'Bloquear',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get Reportar {
    return Intl.message(
      'Report',
      name: 'Reportar',
      desc: '',
      args: [],
    );
  }

  /// `Bug report`
  String get ReporteFallos {
    return Intl.message(
      'Bug report',
      name: 'ReporteFallos',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get PoliticaDePrivacidad {
    return Intl.message(
      'Privacy policy',
      name: 'PoliticaDePrivacidad',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get TerminosyCondiciones {
    return Intl.message(
      'Terms and conditions',
      name: 'TerminosyCondiciones',
      desc: '',
      args: [],
    );
  }

  /// `censorship`
  String get FalloCensura {
    return Intl.message(
      'censorship',
      name: 'FalloCensura',
      desc: '',
      args: [],
    );
  }

  /// `sensitive content filtering`
  String get FiltracionContenidoSensible {
    return Intl.message(
      'sensitive content filtering',
      name: 'FiltracionContenidoSensible',
      desc: '',
      args: [],
    );
  }

  /// `Camera A/R`
  String get CamaraAR {
    return Intl.message(
      'Camera A/R',
      name: 'CamaraAR',
      desc: '',
      args: [],
    );
  }

  /// ` failure with AR mode`
  String get FalloAR {
    return Intl.message(
      ' failure with AR mode',
      name: 'FalloAR',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get Otro {
    return Intl.message(
      'Other',
      name: 'Otro',
      desc: '',
      args: [],
    );
  }

  /// `describe the problem`
  String get DescribeFallo {
    return Intl.message(
      'describe the problem',
      name: 'DescribeFallo',
      desc: '',
      args: [],
    );
  }

  /// `what do you want to improve?`
  String get QueDeseasQueMejoremos {
    return Intl.message(
      'what do you want to improve?',
      name: 'QueDeseasQueMejoremos',
      desc: '',
      args: [],
    );
  }

  /// `attach a photo`
  String get AdjuntarFoto {
    return Intl.message(
      'attach a photo',
      name: 'AdjuntarFoto',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Enviar {
    return Intl.message(
      'Send',
      name: 'Enviar',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get Copiar {
    return Intl.message(
      'Copy',
      name: 'Copiar',
      desc: '',
      args: [],
    );
  }

  /// `Send this address to the person who will send your Realities`
  String get reciveDescrip {
    return Intl.message(
      'Send this address to the person who will send your Realities',
      name: 'reciveDescrip',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copyClip {
    return Intl.message(
      'Copied to clipboard',
      name: 'copyClip',
      desc: '',
      args: [],
    );
  }

  /// `Recents`
  String get recientes {
    return Intl.message(
      'Recents',
      name: 'recientes',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get UserName {
    return Intl.message(
      'Username',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get Obligatorio {
    return Intl.message(
      'Required',
      name: 'Obligatorio',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Guardar {
    return Intl.message(
      'Save',
      name: 'Guardar',
      desc: '',
      args: [],
    );
  }

  /// `no pending requests`
  String get NoSolicitudes {
    return Intl.message(
      'no pending requests',
      name: 'NoSolicitudes',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Si {
    return Intl.message(
      'Yes',
      name: 'Si',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Do you want sync your near wallet?`
  String get PvinecularNearWallet {
    return Intl.message(
      'Do you want sync your near wallet?',
      name: 'PvinecularNearWallet',
      desc: '',
      args: [],
    );
  }

  /// `This will be your avatar`
  String get EsteSeraTuAvatar {
    return Intl.message(
      'This will be your avatar',
      name: 'EsteSeraTuAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get Confirmar {
    return Intl.message(
      'Confirm',
      name: 'Confirmar',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Volver {
    return Intl.message(
      'Back',
      name: 'Volver',
      desc: '',
      args: [],
    );
  }

  /// `Incomplete data`
  String get DatosIncompletos {
    return Intl.message(
      'Incomplete data',
      name: 'DatosIncompletos',
      desc: '',
      args: [],
    );
  }

  /// `You are not sync a wallet`
  String get NoRegistraWalletTitle {
    return Intl.message(
      'You are not sync a wallet',
      name: 'NoRegistraWalletTitle',
      desc: '',
      args: [],
    );
  }

  /// `you will not be able to store or transact within Reality Near`
  String get NoRegistraWalletDesc1 {
    return Intl.message(
      'you will not be able to store or transact within Reality Near',
      name: 'NoRegistraWalletDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Whenever you want, you can link your Near Wallet from the home or main menu`
  String get NoRegistraWalletDesc2 {
    return Intl.message(
      'Whenever you want, you can link your Near Wallet from the home or main menu',
      name: 'NoRegistraWalletDesc2',
      desc: '',
      args: [],
    );
  }

  /// `you don't have notifications`
  String get NoTinesNotificaciones {
    return Intl.message(
      'you don\'t have notifications',
      name: 'NoTinesNotificaciones',
      desc: '',
      args: [],
    );
  }

  /// `Verify the data you entered and try again`
  String get VerificaLosDatosIngresados {
    return Intl.message(
      'Verify the data you entered and try again',
      name: 'VerificaLosDatosIngresados',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get Intentardenuevo {
    return Intl.message(
      'Try again',
      name: 'Intentardenuevo',
      desc: '',
      args: [],
    );
  }

  /// `You don't have friends yet, you can add them with the + button`
  String get NoHayAmigos {
    return Intl.message(
      'You don\'t have friends yet, you can add them with the + button',
      name: 'NoHayAmigos',
      desc: '',
      args: [],
    );
  }

  /// `exchange`
  String get Canjear {
    return Intl.message(
      'exchange',
      name: 'Canjear',
      desc: '',
      args: [],
    );
  }

  /// `You dont have a repeated coupon`
  String get CuponRepetido {
    return Intl.message(
      'You dont have a repeated coupon',
      name: 'CuponRepetido',
      desc: '',
      args: [],
    );
  }

  /// `Invalid coupon`
  String get CuponInvalido {
    return Intl.message(
      'Invalid coupon',
      name: 'CuponInvalido',
      desc: '',
      args: [],
    );
  }

  /// `New update`
  String get NuevaActualizacion {
    return Intl.message(
      'New update',
      name: 'NuevaActualizacion',
      desc: '',
      args: [],
    );
  }

  /// `We recommend having your app updated so you can enjoy the latest news`
  String get ActualizacionDesc {
    return Intl.message(
      'We recommend having your app updated so you can enjoy the latest news',
      name: 'ActualizacionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Actualizar {
    return Intl.message(
      'Update',
      name: 'Actualizar',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get luego {
    return Intl.message(
      'After',
      name: 'luego',
      desc: '',
      args: [],
    );
  }

  /// `Select your avatar`
  String get selectAvatar {
    return Intl.message(
      'Select your avatar',
      name: 'selectAvatar',
      desc: '',
      args: [],
    );
  }

  /// `to change permissions, please go to the configuration section of your device`
  String get ChangePermission {
    return Intl.message(
      'to change permissions, please go to the configuration section of your device',
      name: 'ChangePermission',
      desc: '',
      args: [],
    );
  }

  /// `Go to configuration`
  String get irConfig {
    return Intl.message(
      'Go to configuration',
      name: 'irConfig',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}