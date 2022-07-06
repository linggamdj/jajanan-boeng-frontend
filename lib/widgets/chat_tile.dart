import 'package:flutter/material.dart';
import 'package:jajanan_boeng/models/message_model.dart';
import 'package:jajanan_boeng/models/product_model.dart';
import 'package:jajanan_boeng/pages/detail_chat_page.dart';
import 'package:jajanan_boeng/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  ChatTile(this.message);

  @override
  Widget build(BuildContext context) {
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
                Image.asset(
                  'assets/ic_logo.png',
                  width: 34,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
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
              color: Color(
                0xff2B2939,
              ),
            )
          ],
        ),
      ),
    );
  }
}
