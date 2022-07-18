import 'package:flutter/cupertino.dart';
import 'package:reality_near/presentation/views/FriendsScreen/friendsScreen.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/chatRoomScreen.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/widgets/chatUserDetail.dart';
import 'package:reality_near/presentation/views/configurationScreen/configurationScreen.dart';
import 'package:reality_near/presentation/views/firstScreen/firstScreen.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:reality_near/presentation/views/login/login.dart';
import 'package:reality_near/presentation/views/onboard/onboard.dart';
import 'package:reality_near/presentation/views/register/createUser.dart';
import 'package:reality_near/presentation/views/register/registerScreen.dart';
import 'package:reality_near/presentation/views/userProfile/userProfile.dart';
import 'package:reality_near/presentation/views/userScreen/userScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/receiveScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/transferScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/walletScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/transactionDetail.dart';

final Map<String, WidgetBuilder> routes = {
  FirstScreen.routeName: (context) => const FirstScreen(),
  Login.routeName: (context) => Login(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  OnBoard.routeName: (context) => OnBoard(),
  FriendScreen.routeName: (context) => const FriendScreen(),
  ConfigurationScreen.routeName: (context) => const ConfigurationScreen(),
  InfoScreen.routeName: (context) => const InfoScreen(),
  BugScreen.routeName: (context) => const BugScreen(),
  ChatRoomScreen.routeName: (context) => const ChatRoomScreen(),
  chatUserDetail.routeName: (context) => const chatUserDetail(),
  WalletScreen.routeName: (context) => const WalletScreen(),
  userScreen.routeName: (context) => const userScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  CreateUserScreen.routeName: (context) => CreateUserScreen(),
  ReceiveScreen.routeName: (context) => const ReceiveScreen(),
  TransferScreen.routeName: (context) => TransferScreen(),
  TransferDetail.routeName: (context) => TransferDetail(),
  UserProfile.routeName: (context) => UserProfile(),
};
