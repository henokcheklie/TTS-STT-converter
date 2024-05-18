// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zconverter/HomePage.dart';

class About extends StatefulWidget {
  const About({super.key});
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.about,
          style: GoogleFonts.inconsolata(
            // ignore: deprecated_member_use
            color: Theme.of(context).bottomAppBarColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Opacity(
              opacity: 0.8,
              child: ClipPath(
                clipper: PageClipper(),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.fromLTRB(0, 15, 10, 10),
                  color: Theme.of(context).shadowColor,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            //////////////////////////////////

            ContactUs(
              logo: AssetImage('assets/logo.png'),
              companyName: 'Habesha',
              tagLine: AppLocalizations.of(context)!.tagLine,
              taglineFontWeight: FontWeight.w400,
              companyFontSize: 25,
              textColor: Theme.of(context).bottomAppBarColor,
              cardColor: Theme.of(context).backgroundColor,
              companyColor: Theme.of(context).bottomAppBarColor,
              taglineColor: Theme.of(context).bottomAppBarColor,
              avatarRadius: 40.0,
              dividerThickness: 2,
              //////////////////////////
              email: 'habesha@gmail.com',
              instagram: 'habesha',
              phoneNumber: '+2519********',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
