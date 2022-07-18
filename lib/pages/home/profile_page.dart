import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/transaction_provider.dart';
import 'package:jajanan_boeng/providers/logout_provider.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jajanan_boeng/theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    Provider.of<TransactionProvider>(context).getTransactions(user.token);
    LogoutProvider logoutProvider = Provider.of<LogoutProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    handleLogout() async {
      await logoutProvider.logout(user.token);
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Berhasil Logout',
            textAlign: TextAlign.center,
          ),
        ),
      );
      pageProvider.currentIndex = 0;
    }

    launchWhatsapp() async {
      var number = '6285883108842';
      var text =
          "Halo%20Jajanan%20Bo'eng,%20nama%20saya%20${user.name}%20ingin%20melakukan%20konfirmasi%20pembayaran.%0aBerikut%20bukti%20screenshot%20transfernya%20:%20";
      var url = Uri.parse("whatsapp://send?phone=$number&text=$text");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Anda Tidak Memiliki Whatsapp! Silakan Install Dahulu.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    launchInstagram() async {
      var url = Uri.parse("https://www.instagram.com/jajananboeng/");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Sedang dalam Perbaikan',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              defaultMargin,
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    user.profilePhotoUrl,
                    width: 64,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name}',
                        style: whiteTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleLogout();
                  },
                  child: Image.asset(
                    'assets/new_icon/logout-icon.png',
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(
          top: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: tertiaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: backgroundColor5,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: backgroundColor7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Account',
                style: orangeTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: menuItem(
                  'Edit Profile',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/transactions');
                },
                child: menuItem(
                  'Pesanan Anda',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/change-password');
                },
                child: menuItem(
                  'Ganti Password',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'General',
                style: orangeTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchWhatsapp();
                },
                child: menuItem(
                  'Konfirmasi Pesanan (WA)',
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchInstagram();
                },
                child: menuItem(
                  'Follow Instagram Kami',
                ),
              ),
              menuItem(
                'Beri Penilaian',
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
