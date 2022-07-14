import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/product_model.dart';
import 'package:jajanan_boeng/pages/detail_chat_page.dart';
import 'package:jajanan_boeng/providers/cart_provider.dart';
import 'package:jajanan_boeng/providers/wishlist_provider.dart';
import 'package:jajanan_boeng/theme.dart';

class ProductPage extends StatefulWidget {
  late final ProductModel product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/new_icon/success-icon.png',
                    width: 100,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Berhasil Ditambah',
                    style: orangeTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Produk ini telah berhasil ditambahkan ke keranjang',
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : secondaryTextColor,
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            color: primaryColor,
            padding: EdgeInsets.only(
              top: 10,
              left: defaultMargin,
              right: defaultMargin,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: backgroundColor7,
                    child: Icon(
                      Icons.chevron_left,
                      color: primaryColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: defaultMargin,
                      right: defaultMargin,
                    ),
                    child: Text(
                      widget.product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: whiteTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: CircleAvatar(
                    backgroundColor: backgroundColor7,
                    child: Icon(
                      Icons.shopping_bag,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries
                .map(
                  (image) => Image.network(
                    image.url,
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          )
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor7,
        ),
        child: Column(
          children: [
            // Header
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: orangeTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category.name,
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      wishlistProvider.setProduct(widget.product);
                      if (wishlistProvider.isWishlist(widget.product)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: primaryColor,
                            content: Text(
                              'Berhasil ditambahkan ke favorit',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: alertColor,
                            content: Text(
                              'Telah dihapus dari favorit',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Image.asset(
                      wishlistProvider.isWishlist(widget.product)
                          ? 'assets/new_icon/love-active.png'
                          : 'assets/new_icon/love.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              padding: EdgeInsets.all(
                16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor8,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga mulai dari',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\RP ${widget.product.price}',
                    style: orangeTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            // Desc
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: orangeTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description,
                    style: subtitleTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget customButton() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(
          defaultMargin,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailChatPage(widget.product),
                  ),
                );
              },
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/new_icon/chat-button.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 54,
                child: TextButton(
                  onPressed: () {
                    cartProvider.addCart(widget.product);
                    showSuccessDialog();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'Tambah ke Keranjang',
                    style: whiteTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor7,
      bottomNavigationBar: customButton(),
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
