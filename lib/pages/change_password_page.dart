import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/logout_provider.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:jajanan_boeng/widgets/loading_button.dart';
import 'package:jajanan_boeng/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    LogoutProvider logoutProvider = Provider.of<LogoutProvider>(context);

    TextEditingController newPasswordController =
        TextEditingController(text: '');

    TextEditingController confirmNewPasswordController =
        TextEditingController(text: '');

    handleChangePassword() async {
      setState(() {
        isLoading = true;
      });

      if (newPasswordController.text == confirmNewPasswordController.text) {
        if (newPasswordController.text != '' ||
            confirmNewPasswordController.text != '') {
          if (newPasswordController.text.length >= 8) {
            if (await authProvider.changePassword(
              authProvider.user.token,
              newPasswordController.text,
            )) {
              await logoutProvider.logout(user.token);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: primaryColor,
                  content: Text(
                    'Berhasil Mengganti Password! Silakan Login Kembali',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              pageProvider.currentIndex = 0;
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: alertColor,
                  content: Text(
                    'Server Sedang Bermasalah! Silakan Coba Beberapa Saat Lagi.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: alertColor,
                content: Text(
                  'Panjang Password Harus Minimal 8 Karakter!',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              content: Text(
                'Password Tidak Boleh Kosong!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Konfirm Password Tidak Cocok!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    header() {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ganti Password',
        ),
      );
    }

    Widget newPasswordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Baru',
              style: orangeTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget confirmNewPasswordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konfrim Password Baru',
              style: orangeTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget updateButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, bottom: 30),
        child: TextButton(
          onPressed: handleChangePassword,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Update Password',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: ListView(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                    user.profilePhotoUrl,
                  ),
                ),
                border: Border.all(color: primaryColor),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            newPasswordInput(),
            confirmNewPasswordInput(),
            isLoading ? LoadingButton() : updateButton(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor7,
      appBar: header(),
      body: content(),
    );
  }
}
