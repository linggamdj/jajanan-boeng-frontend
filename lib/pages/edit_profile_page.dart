import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:jajanan_boeng/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController nameController =
        TextEditingController(text: user.name);

    TextEditingController addressController =
        TextEditingController(text: user.address);

    TextEditingController phoneController =
        TextEditingController(text: user.phone);

    handleUpdate() async {
      if (await authProvider.update(
        authProvider.user.token,
        nameController.text,
        addressController.text,
        phoneController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: Text(
              'Edit profile berhasil! Silakan login kembali',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushNamed(context, '/');
        pageProvider.currentIndex = 0;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Update Data',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
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
          'Edit Profile',
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Lengkap',
              style: orangeTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: nameController,
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

    Widget addressInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Pengiriman',
              style: orangeTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: addressController,
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

    Widget phoneInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Hanphone',
              style: orangeTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: phoneController,
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
          onPressed: handleUpdate,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Update Profile',
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
            nameInput(),
            addressInput(),
            phoneInput(),
            updateButton(),
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
