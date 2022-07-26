import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/pages/home/chat_page.dart';
import 'package:jajanan_boeng/pages/home/home_page.dart';
import 'package:jajanan_boeng/pages/home/profile_page.dart';
import 'package:jajanan_boeng/pages/home/wishlist_page.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:jajanan_boeng/theme.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 16,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: backgroundColor1,
                  spreadRadius: 100,
                  blurRadius: 100,
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xffFDFDFD),
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                print(value);
                pageProvider.currentIndex = value;
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/btn_home.png',
                      width: 21,
                      color: pageProvider.currentIndex == 0
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/ic_chat.png',
                      width: 20,
                      color: pageProvider.currentIndex == 1
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: 'Pesan',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Image.asset(
                      'assets/new_icon/ic_cart_fix.png',
                      width: 20,
                      color: pageProvider.currentIndex == 2
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: 'Keranjang',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/ic_wishlist.png',
                      width: 20,
                      color: pageProvider.currentIndex == 3
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: 'Favorit',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Image.asset(
                      'assets/ic_profile_nav.png',
                      width: 20,
                      color: pageProvider.currentIndex == 4
                          ? primaryColor
                          : Color(0xff808191),
                    ),
                  ),
                  label: 'Profil',
                ),
              ],
              selectedItemColor: primaryColor,
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return ChatPage();
          break;
        case 2:
          return CartPage();
          break;
        case 3:
          return WishListPage();
          break;
        case 4:
          return ProfilePage();
          break;
        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor7,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
