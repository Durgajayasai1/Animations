import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class AddToCartAnimation extends StatefulWidget {
  const AddToCartAnimation({super.key});

  @override
  State<AddToCartAnimation> createState() => AddToCartAnimationState();
}

class AddToCartAnimationState extends State<AddToCartAnimation> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            title: Text(
              "flutter_devote",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          )),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          child: AnimatedContainer(
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
            width: isClicked ? 200 : 80,
            height: 60,
            decoration: BoxDecoration(
                color: isClicked ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(isClicked ? 30 : 20)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isClicked)
                  Positioned.fill(
                    child: Lottie.asset('assets/lottie/confetti.json',
                        repeat: false, fit: BoxFit.cover),
                  ),
                Row(
                  mainAxisAlignment: isClicked
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    Icon(
                      isClicked ? Icons.check : Iconsax.bag_2,
                      color: isClicked ? Colors.white : Colors.black,
                    ),
                    if (isClicked)
                      Flexible(
                        child: Text(
                          "Added to cart",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
