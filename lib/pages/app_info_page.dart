import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/sign_in_page.dart';
import 'package:jajanan_boeng/theme.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang di Jajanan Bo'eng",
                    style: whiteTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget appinfo() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: defaultMargin,
            ),
            Container(
              // margin: EdgeInsets.only(left: 0, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/rumah-boeng.jpg",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Text(
              'Jajanan Bo’eng merupakan usaha kuliner yang menjual makanan khas Anambas yaitu Luti Gendang. Luti gendang merupakan roti yang dibuat dari olahan tepung terigu, ragi, margarin, susu cair, telur ayam, gula, dan garam sebagai adonan utama dengan isian ikan tuna. Lokasi toko terletak pada Jalan Puspa Asri no. 25 kota Tangerang.',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Widget loginPageButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 12, bottom: defaultMargin),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/sign-in');
          },
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Login atau Register',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
              color: secondaryTextColor,
            ),
          ),
        ),
      );
    }

    Widget procedurePageButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/procedure');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Prosedur Pembelian',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor7,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                appinfo(),
                procedurePageButton(),
                loginPageButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
