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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.quoteLeft,
                    size: 50,
                  ),
                  mediumVerticalSpace(),
                  Text(
                    '"${stoics[index].wisdoms[0]}"',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: GoogleFonts.nanumMyeongjo().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                  mediumVerticalSpace(),
                  Text(
                    '- ${stoics[index].name} -',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: GoogleFonts.nanumMyeongjo().fontFamily,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
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
