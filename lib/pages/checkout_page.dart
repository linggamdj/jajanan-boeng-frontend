import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/cart_provider.dart';
import 'package:jajanan_boeng/providers/checkout_provider.dart';
import 'package:jajanan_boeng/theme.dart';
import 'package:jajanan_boeng/widgets/checkout_card.dart';
import 'package:jajanan_boeng/widgets/loading_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (await checkoutProvider.checkout(
        authProvider.user.token,
        cartProvider.carts,
        cartProvider.totalPrice(),
      )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text('Detail Checkout'),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // List Items
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map(
                        (cart) => CheckoutCard(cart),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          // Address Detail
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              padding: EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                color: backgroundColor4,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Alamat',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/ic_location_rest.png',
                            width: 40,
                          ),
                          Image.asset(
                            'assets/ic_line.png',
                            height: 30,
                          ),
                          Image.asset(
                            'assets/ic_location_cust.png',
                            width: 40,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi Toko',
                                style: secondaryTextStyle.copyWith(
                                    fontSize: 12, fontWeight: light),
                              ),
                              Text(
                                'jl. Puspa Asri no. 25 Tangerang'.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: primaryTextStyle.copyWith(
                                  fontWeight: medium,
                                ),
                              ),
                              SizedBox(
                                height: defaultMargin,
                              ),
                              Text(
                                'Tujuan Pengiriman',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: light,
                                ),
                              ),
                              Text(
                                user.address.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: primaryTextStyle.copyWith(
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Payment Summary
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Pembayaran',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Barang',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harga Total',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '\RP ${cartProvider.totalPrice()}',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pengiriman',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '(VIA Whatsapp)',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ke Rekening',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '7033087609 (BCA A.N. Farhan)',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '\RP ${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Checkout Button
          SizedBox(
            height: defaultMargin,
          ),
          Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: defaultMargin,
                  ),
                  child: LoadingButton())
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: handleCheckout,
                    style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: Text(
                      'Checkout Sekarang',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
