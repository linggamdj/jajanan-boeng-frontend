import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/app_info_page.dart';
import 'package:jajanan_boeng/theme.dart';

class ProcedurePage extends StatelessWidget {
  const ProcedurePage({Key? key}) : super(key: key);

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
                    "Prosedur Pembelian Toko Jajanan Bo'eng",
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

    Widget procedureInfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: defaultMargin,
            ),
            Text(
              '1. Pilih produk yang anda inginkan dan tambahkan ke keranjang',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '2. Lalu pergi ke halaman keranjang untuk melakukan checkout',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '3. Setelah proses checkout berhasil, pergi ke halaman daftar pesanan kemudian copy nomor rekening toko',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '4. Lakukan proses pembayaran ke rekening toko sesuai dengan harga total dari pesanan anda',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '5. Jika sudah, screenshot bukti pembayaran dan lakukan konfirmasi pemesanan melalui tombol "Konfirmasi Pemesanan" di halaman profil',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '6. Setelah pembayaran terverifikasi, pesanan anda akan dikirim melalui Ojek Online dengan metode pembayaran pengiriman COD (Cash on Delivery)',
              style: subtitleTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Widget aboutPageButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Kembali',
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
                procedureInfo(),
                aboutPageButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
