import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/models/message_model.dart';
import 'package:jajanan_boeng/models/product_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/services/message_service.dart';
import 'package:jajanan_boeng/theme.dart';
import 'package:jajanan_boeng/widgets/chat_bubble.dart';

class DetailChatPage extends StatefulWidget {
  late ProductModel product;
  DetailChatPage(this.product);

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController messageController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleAddMessage() async {
      await MessageService().addMessage(
        user: authProvider.user,
        isFromUser: user.roles == 'ADMIN' ? false : true,
        message: messageController.text,
        product: widget.product,
      );

      setState(() {
        widget.product = UninitializedProductModel();
        messageController.text = '';
      });
    }

    header() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AppBar(
              backgroundColor: primaryColor,
              centerTitle: false,
              title: Row(
                children: [
                  user.roles == 'ADMIN'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            snapshot.data![0].userImage,
                            width: 50,
                          ),
                        )
                      : Image.asset(
                          'assets/new_icon/admin-online.png',
                          width: 50,
                        ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.roles == 'ADMIN'
                            ? snapshot.data![0].userName
                            : 'Penjual',
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Online',
                        style: whiteTextStyle.copyWith(
                          fontWeight: light,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor7,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.product.galleries[0].url),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.name,
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Rp${widget.product.price}',
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.product = UninitializedProductModel();
                });
              },
              child: Image.asset(
                'assets/new_icon/delete.png',
                width: 22,
              ),
            ),
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product is UninitializedProductModel
                ? SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor7,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: messageController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Ketikan pesan...',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: handleAddMessage,
                  child: Image.asset(
                    'assets/new_icon/send-message.png',
                    width: 45,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget contentForUser() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              children: snapshot.data!
                  .map(
                    (MessageModel message) => ChatBubble(
                      isSender: !message.isFromUser,
                      text: message.message,
                      product: message.product,
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

    Widget contentForAdmin() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              children: snapshot.data!
                  .map(
                    (MessageModel message) => ChatBubble(
                      isSender: message.isFromUser,
                      text: message.message,
                      product: message.product,
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor8,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: header(),
      ),
      bottomNavigationBar: chatInput(),
      body: user.roles == 'ADMIN' ? contentForAdmin() : contentForUser(),
    );
  }
}
