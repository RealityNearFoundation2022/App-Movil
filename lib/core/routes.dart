import 'package:flutter/cupertino.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/FriendsScreen/chatSoonScreen.dart';
import 'package:reality_near/presentation/views/FriendsScreen/friendsScreen.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/chatRoomScreen.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/widgets/chatUserDetail.dart';
import 'package:reality_near/presentation/views/configurationScreen/configurationScreen.dart';
import 'package:reality_near/presentation/views/firstScreen/firstScreen.dart';
import 'package:reality_near/presentation/views/homeScreen/home_screen.dart';
// import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:reality_near/presentation/views/login/login.dart';
import 'package:reality_near/presentation/views/miniGames/miniGames.dart';
import 'package:reality_near/presentation/views/notificationScreen/notificationScreen.dart';
import 'package:reality_near/presentation/views/qrScreen/qrScanScreen.dart';
import 'package:reality_near/presentation/views/qrScreen/qrViewScreen.dart';
import 'package:reality_near/presentation/views/register/registerScreen.dart';
import 'package:reality_near/presentation/views/social/social_screen.dart';
import 'package:reality_near/presentation/views/userProfile/my_posts.dart';
import 'package:reality_near/presentation/views/userProfile/profile_screen.dart';
import 'package:reality_near/presentation/views/userScreen/userScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/receiveScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/transferScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/walletScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/transactionDetail.dart';

final Map<String, WidgetBuilder> routes = {
  FirstScreen.routeName: (context) => const FirstScreen(),
  Login.routeName: (context) => Login(),
  HomeScreenV2.routeName: (context) => const HomeScreenV2(),
  FriendScreen.routeName: (context) => const FriendScreen(),
  ConfigurationScreen.routeName: (context) => const ConfigurationScreen(),
  InfoScreen.routeName: (context) => const InfoScreen(),
  BugScreen.routeName: (context) => const BugScreen(),
  ChatRoomScreen.routeName: (context) => const ChatRoomScreen(),
  chatUserDetail.routeName: (context) => const chatUserDetail(),
  WalletScreen.routeName: (context) => const WalletScreen(),
  userScreen.routeName: (context) => userScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  ReceiveScreen.routeName: (context) => ReceiveScreen(),
  TransferScreen.routeName: (context) => TransferScreen(),
  TransferDetail.routeName: (context) => TransferDetail(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  QrViewScreen.routeName: (context) => const QrViewScreen(),
  QrScannScreen.routeName: (context) => const QrScannScreen(),
  chatSoonScreen.routeName: (context) => const chatSoonScreen(),
  ARSection.routeName: (context) => const ARSection(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  SocialScreen.routeName: (context) => const SocialScreen(),
  MyPostsScreen.routeName: (context) => const MyPostsScreen(),
  MiniGames.routeName: (context) => const MiniGames(),
};
