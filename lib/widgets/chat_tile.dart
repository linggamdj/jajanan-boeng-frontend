import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/models/message_model.dart';
import 'package:jajanan_boeng/models/product_model.dart';
import 'package:jajanan_boeng/pages/detail_chat_page.dart';
import 'package:jajanan_boeng/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message, userMessage;
  ChatTile(this.message, this.userMessage);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatPage(
              UninitializedProductModel(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                user.roles == 'USER'
                    ? Image.asset(
                        'assets/new_icon/admin.png',
                        width: 34,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          userMessage.userImage,
                          width: 34,
                        ),
                      ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.roles == 'USER' ? 'Penjual' : userMessage.userName,
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        message.message,
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
