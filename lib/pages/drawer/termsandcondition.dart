import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions\n',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '''
ACCEPTANCE OF TERMS
You must accept these terms of service to use
        BTOLET.com. This is a legal agreement
        ('Agreement"') between You and
        BTOLET.com Pvt. Ltd. ("Company"), for use
        of the BTOLET.com services. "You" refers to
        the person who has registered or taken any
        services from BTOLET.com. You have to
        acknowledge these terms as a contract
        between you and BTOLET.com. The Company may at its sole discretion modify
        the features of the Services from time to time
        without prior notice. BTOLET.com reserves
        the right at any time and from time to time to
        modify or discontinue, temporarily or
        permanently, the Service (or any part thereof)
        with or without notice.
        
        ACCOUNTS, PASSWORD AND SECURITY
        You will receive a password and account
        designation upon completing the Service's
        registration process. You are responsible for
        maintaining the confidentiality of the
        password and account. Your password is
        stored in hashed and encrypted manner, using
        highly secured algorithms, even though we
        can't decipher it.
        CONTENT AND DATA
        We claim no intellectual property rights over
        the data and material you provide to the
        website. All materials uploaded remain yours.
        ACCOUNT DATA DELETION
        We don't share anything we gather from you
        or from your social account you used to login.
        But still if you want to deactivate/delete your
        account and all the information linked with
        your account, please feel free to contact us in
        our email info@BTOLET.com with your login
        username and your mobile number. We'll get
        back to you as soon as possible
        
        
        
        DISPUTE BETWEEN BUYER AND SELLER
        Situations may come where there is dispute
        between the buyer and seller. BTOLET.com
        does not guarantee or promise anything in
        terms of the correctness of the information
        provided by the seller or buyer. For any
        damage to the seller due to the buyer and any
        damage due to the buyer due to the seller,
        BTOLET.com will not be absolutely
        responsible for that.
        CONDUCT ON BTOLET.COM
        You may not use the BTOLET.com Platform
        to:
        Upload, post, transmit, or otherwise make
        available any of Your Data that is unlawful,
        harmful, threatening, abusive, harassing,
        tortious, defamatory, vulgar, obscene, libelous,
        invasive of another's privacy, hateful, or
        racially, ethnically, or otherwise objectionable.
        
        
        
        BILLING
        You are not obligated to purchase any of the
        Services. If You elect to purchase Service
        packages or additional Services, you may elect
        to provide a credit card or other payment
        mechanism selected by You.
        You agree that the Company may charge to
        Your credit card or other payment mechanism
        selected by You and approved by the
        Company for Your Prepaid Account ("Your
        Account") and all amounts due and owing for
        the Services, including service fees,
        subscription fees or any other fee or charge
        associated with Your use of the Services.
        Prices of all Services are subject to change at
        any time.
        All payments authorized by you into your
        account are final. There is no refunding of your
        account regardless of whether you use the
        Services or not.
        Government Taxes will be applicable wherever
        necessary.
        
        
        
        
        CHANGING YOUR SERVICE LEVEL
        Some services provided by BTOLET.com
        allow you to upgrade your service levels.
        If you upgrade your service level from one
        package to a higher priced package, the
        Company will charge you the applicable
        amount.
        There are no downgrade options available and
        no refunds.
        CANCELLATION OF ACCOUNT
        You are solely responsible for properly
        canceling your account. An email is necessary
        to cancel your account. BTOLET.com will
        cancel
        your account once email confirmation is
        received. All of your content will immediately
        be inaccessible from the Service upon
        cancellation. This information cannot be
        recovered once the account has been
        canceled.
        GOVERNING LAW
        These Terms will be governed by the laws of
        the Federal Democratic Republic of Nepal,
        without regard to its conflict of laws principles.
        
        
        DISCLAIMER; limitation of liability
        Errors. A possibility exists that our website or
        materials could include inaccuracies or errors
        or information or materials that violate these
        Terms. Additionally, a possibility exists that
        unauthorized alterations could be made by
        third parties to our website or materials.
        Although we attempt to ensure the integrity of
        our website, we make no guarantees as to its
        completeness or correctness. If a situation
        arises in which our website's completeness or
        correctness is in question, please contact us
        via our contact information provided on our
        "Support" page of the website with, if possible,
        a description of the material to be checked
        and the location (URL) where such material
        can be found on our website.
        If you have any questions regarding this
        Agreement or if you wish to discuss the terms
        of service contained herein please contact
        BTOLET.com Limited using the contact
        details at our contact page.''',
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
