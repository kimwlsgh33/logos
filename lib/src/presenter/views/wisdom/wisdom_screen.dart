import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/data/sources/remote/wisdom_provider.dart';

class WisdomScreen extends StatefulWidget {
  const WisdomScreen({super.key});

  @override
  State<WisdomScreen> createState() => _WisdomScreenState();
}

class _WisdomScreenState extends State<WisdomScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.quoteLeft,
                          size: 50,
                        ),
                        mediumVerticalSpace(),
                        Row(
                          children: [
                            Text(
                              '"',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: GoogleFonts.nanumMyeongjo().fontFamily,
                              ),
                            ),
                            Text(
                              wisdoms[index],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily:
                                    GoogleFonts.nanumMyeongjo().fontFamily,
                              ),
                            ),
                            Text(
                              '"',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: GoogleFonts.nanumMyeongjo().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            mediumVerticalSpace(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              onPressed: () {
                setState(() {
                  index = index == wisdoms.length - 1 ? 0 : index + 1;
                });
              },
              child: Text(
                "Next",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
