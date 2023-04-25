import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onestop_api/widget/About.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double rating;

  var items = [
    PlaceInfo('BG Remover', 4.9, 'Flutter • removebg API',
        '/BgRemoverHomeScreen', 'assets/BG.png'),
    PlaceInfo('Crypto List', 4.3, 'Flutter • CoinGecko API',
        '/Cryptohomescreen', 'assets/Crypto.png'),
    PlaceInfo('Quotes Scraper', 3.8, 'Flutter • quotes.toscrape.com',
        '/QuotehomeScreen', 'assets/quote.png'),
    PlaceInfo('Recipe Generator', 4.1, 'Flutter • TheMealDB', '/MealhomeScreen',
        'assets/Meal.png'),
    PlaceInfo('Text Extractor', 3.9, 'Flutter • OCR.Space',
        '/textRecoghomescreen', 'assets/text.png')
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xFF035AA6).withAlpha(1000),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(123.0),
            child: AppBar(
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFF035AA6).withAlpha(200),
              elevation: 0,
              title: const Center(
                child: Text(
                  'OneStop API',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: 1000,
                margin: const EdgeInsets.only(top: 155),
                decoration: const BoxDecoration(
                    color: Color(0xFFF1EFF1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, items[index].routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        // color: Colors.blueAccent,
                        height: 160,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              height: 136,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(22),
                                  color: const Color(0xFF40BAD5),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 15),
                                        blurRadius: 35,
                                        color: Colors.black12)
                                  ]),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                22)),
                                  ),
                                  Positioned(
                                      top: 10,
                                      left: 30,
                                      child: Text(
                                        items[index].name,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      )),
                                  Positioned(
                                      top: 50,
                                      left: 30,
                                      child: Text(items[index].category,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500))),
                                  Positioned(
                                    top: 100,
                                    left: 0,
                                    child: Stack(children: <Widget>[
                                      Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(22)),
                                              color: Color(0xFF40BAD5)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20 * 1.8,
                                              vertical: 45),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                items[index].rating.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Avenir',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            RatingBar(
                                                rating: items[index].rating),
                                          ]),
                                        ],
                                      )
                                    ]),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 190,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: 140,
                                        width: 180,
                                        child: Image.asset(items[index].image,
                                            fit: BoxFit.cover),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              // Positioned(
              //     top: -28,
              //     child: Container(
              //         width: 500, height: 100, color: const Color(0xFF035AA6))),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            height: 44.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF846AFF).withOpacity(0.9),
                    const Color(0xFF755EE8).withOpacity(0.9),
                  ],
                )),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AboutPage())));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Icon(Icons.person_4_outlined),
            ),
          )),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do you want to Exit the app?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          );
        });
    return exitApp ?? false;
  }
}

RatingBar({required double rating}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(rating.floor(), (index) {
      return const Icon(
        Icons.star,
        color: Colors.white,
        size: 12,
      );
    }),
  );
}

class PlaceInfo {
  final String name;
  final String category;
  final double rating;
  final String routeName;
  final String image;

  PlaceInfo(this.name, this.rating, this.category, this.routeName, this.image);
}
