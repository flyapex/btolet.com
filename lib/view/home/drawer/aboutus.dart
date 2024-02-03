import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Btolet.com',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Text(
                '🏠 Btolet.com provides services to those who want to buy, sell, and rent their properties. It is an online marketplace for those who want to deal with properties in Bangladesh. It is a platform where the buyer and the seller can deal with the properties directly with each other. Btolet.com is simply a bridge between the buyers and the sellers.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our Vision\n\n'
                'If you are someone who wants to sell your properties at a good price, then you can post the details about your properties on Btolet.com. Btolet.com reviews the information you have provided about your property and publishes it on the website/app for the public to see. 🌟\n\n'
                'For more details about Btolet.com services, please visit here. Once the property is sold, it will be removed from the website.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our Mission\n\n'
                'If you are a buyer, you can find a lot of nice properties and directly contact and negotiate with the sellers. If you are thinking of letting your properties for rent, you can also put your property details so that those who are seeking properties for rent will contact you.\n\n'
                'Information about the properties listed on the site is taken from the consent of the sellers. In case of the wrong information, the seller will be responsible for that. Btolet.com is not responsible for any wrong information provided by the sellers. ⚠️',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
