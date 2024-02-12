import 'package:btolet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Feather.chevron_left),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Back',
          style: TextStyle(
            fontSize: s1,
            height: 0.5,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ACCEPTANCE OF TERMS\n'
                'You must accept these terms of service to use BTOLET.com. This is a legal agreement '
                "('Agreement') between You and BTOLET.com Pvt. Ltd. ('Company'), for use of the BTOLET.com services. "
                '"You" refers to the person who has registered or taken any services from BTOLET.com. You have to '
                'acknowledge these terms as a contract between you and BTOLET.com. The Company may at its sole discretion '
                'modify the features of the Services from time to time without prior notice. BTOLET.com reserves '
                'the right at any time and from time to time to modify or discontinue, temporarily or '
                'permanently, the Service (or any part thereof) with or without notice.\n\n'
                'ACCOUNTS, PASSWORD AND SECURITY\n'
                'You will receive a password and account designation upon completing the Service\'s '
                'registration process. You are responsible for maintaining the confidentiality of the '
                'password and account. Your password is stored in hashed and encrypted manner, using highly '
                "secured algorithms, even though we can't decipher it.\n\n"
                'CONTENT AND DATA\n'
                'We claim no intellectual property rights over the data and material you provide to the website. '
                'All materials uploaded remain yours.\n\n'
                'ACCOUNT DATA DELETION\n'
                'We don\'t share anything we gather from you or from your social account you used to login. '
                'But still if you want to deactivate/delete your account and all the information linked with '
                'your account, please feel free to contact us in our email info@BTOLET.com with your login '
                'username and your mobile number. We\'ll get back to you as soon as possible.\n\n'
                'DISPUTE BETWEEN BUYER AND SELLER\n'
                'Situations may come where there is dispute between the buyer and seller. BTOLET.com does not '
                'guarantee or promise anything in terms of the correctness of the information provided by the '
                'seller or buyer. For any damage to the seller due to the buyer and any damage due to the buyer '
                'due to the seller, BTOLET.com will not be absolutely responsible for that.\n\n'
                'CONDUCT ON BTOLET.COM\n'
                'You may not use the BTOLET.com Platform to: Upload, post, transmit, or otherwise make available '
                'any of Your Data that is unlawful, harmful, threatening, abusive, harassing, tortious, defamatory, '
                'vulgar, obscene, libelous, invasive of another\'s privacy, hateful, or racially, ethnically, or '
                'otherwise objectionable.\n\n'
                'BILLING\n'
                'You are not obligated to purchase any of the Services. If You elect to purchase Service packages '
                'or additional Services, you may elect to provide a credit card or other payment mechanism selected '
                'by You. You agree that the Company may charge to Your credit card or other payment mechanism '
                'selected by You and approved by the Company for Your Prepaid Account ("Your Account") and all '
                'amounts due and owing for the Services, including service fees, subscription fees or any other '
                'fee or charge associated with Your use of the Services. Prices of all Services are subject to '
                'change at any time. All payments authorized by you into your account are final. There is no '
                'refunding of your account regardless of whether you use the Services or not. Government Taxes '
                'will be applicable wherever necessary.\n\n'
                'CHANGING YOUR SERVICE LEVEL\n'
                'Some services provided by BTOLET.com allow you to upgrade your service levels. If you upgrade '
                'your service level from one package to a higher priced package, the Company will charge you the '
                'applicable amount. There are no downgrade options available and no refunds.\n\n'
                'CANCELLATION OF ACCOUNT\n'
                'You are solely responsible for properly canceling your account. An email is necessary to cancel '
                'your account. BTOLET.com will cancel your account once email confirmation is received. All of your '
                'content will immediately be inaccessible from the Service upon cancellation. This information '
                'cannot be recovered once the account has been canceled.\n\n'
                'GOVERNING LAW\n'
                'These Terms will be governed by the laws of the Federal Democratic Republic of Nepal, without '
                'regard to its conflict of laws principles.\n\n'
                'DISCLAIMER; limitation of liability\n'
                'Errors. A possibility exists that our website or materials could include inaccuracies or errors '
                'or information or materials that violate these Terms. Additionally, a possibility exists that '
                'unauthorized alterations could be made by third parties to our website or materials. Although we '
                'attempt to ensure the integrity of our website, we make no guarantees as to its completeness or '
                'correctness. If a situation arises in which our website\'s completeness or correctness is in '
                'question, please contact us via our contact information provided on our "Support" page of the '
                'website with, if possible, a description of the material to be checked and the location (URL) '
                'where such material can be found on our website. If you have any questions regarding this Agreement '
                'or if you wish to discuss the terms of service contained herein please contact BTOLET.com Limited '
                'using the contact details at our contact page.',
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
