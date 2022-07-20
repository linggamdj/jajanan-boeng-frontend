import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/models/message_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:jajanan_boeng/services/message_service.dart';
import 'package:jajanan_boeng/theme.dart';
import 'package:jajanan_boeng/widgets/chat_tile.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserModel user = authProvider.user;

    Widget header() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          user.roles == 'USER' ? 'Chat Penjual' : 'Chat Pelanggan',
        ),
        elevation: 0,
      );
    }

    Widget emptyChat() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          width: double.infinity,
          color: backgroundColor7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/new_icon/headset.png',
                width: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Kamu belum pernah melakukan chat',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Silakan memulai chat dengan memilih salah satu produk, kemudian klik logo chat',
                textAlign: TextAlign.center,
                style: secondaryTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                child: TextButton(
                  onPressed: () {
                    pageProvider.currentIndex = 0;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cari Produk',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget contentForUser() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return emptyChat();
            }

            return Expanded(
              child: Container(
                width: double.infinity,
                color: backgroundColor7,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: [
                    ChatTile(snapshot.data![snapshot.data!.length - 1]),
                  ],
                ),
              ),
            );
          } else {
            return emptyChat();
          }
        },
      );
    }

    Widget contentForAdmin() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return emptyChat();
            }

            return Expanded(
              child: Container(
                width: double.infinity,
                color: backgroundColor7,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: [
                    ChatTile(snapshot.data![snapshot.data!.length - 1]),
                  ],
                ),
              ),
            );
          } else {
            return emptyChat();
          }
        },
      );
    }

    return Column(
      children: [
        header(),
        user.roles == 'USER' ? contentForUser() : contentForAdmin(),
      ],
    );
  }
}
