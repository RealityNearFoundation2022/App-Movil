import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/widgets/chatUserDetail.dart';

class ChatRoomScreen extends StatefulWidget {
//Variable
  static String routeName = "/chatRoomScreen";

  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
//Variables
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
//Inicio de la pantalla
  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'jibasdyg67a54436745643d56as13',
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    //variables como argumentos
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (args['empty']) {
      _messages.clear();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greenPrimary,
        toolbarHeight: 65,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, chatUserDetail.routeName, arguments: {
              'name': "Juan Perez Alcazar",
              'photo': "https://picsum.photos/700/400?random",
              'contect': true
            });
          },
          child: Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    args['name'],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(args['photo']),
                ),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 35),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          inputBackgroundColor: greenPrimary,
          primaryColor: greenPrimary3,
          inputTextCursorColor: Colors.white,
        ),
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
        emptyState: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(args['photo']),
            ),
            const SizedBox(height: 20),
            Text(
              args['name'],
              style: GoogleFonts.sourceSansPro(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Se el primero en escribir un mensaje',
              style: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
