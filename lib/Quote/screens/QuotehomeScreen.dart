// ignore_for_file: camel_case_types

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:onestop_api/Quote/screens/quotespage.dart';

class QuotehomeScreen extends StatefulWidget {
  const QuotehomeScreen({super.key});

  @override
  State<QuotehomeScreen> createState() => _QuotehomeScreenState();
}

class _QuotehomeScreenState extends State<QuotehomeScreen> {
  List<String> categories = ["love", "inspirational", "life", "humor"];

  List quotes = [];
  List author = [];
  bool isDataThere = false;
  @override
  void initState() {
    super.initState();
    getquotes();
  }

  getquotes() async {
    String url = "http://quotes.toscrape.com/";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final quoteclass = document.getElementsByClassName("quote");
    for (int i = 0; i < quoteclass.length; i++) {
      quotes.add(quoteclass[i].getElementsByClassName('text')[0].innerHtml);
    }
    author = quoteclass
        .map((element) => element.getElementsByClassName('author')[0].innerHtml)
        .toList();

    setState(() {
      isDataThere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'Quotes App',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'How to use:\n\n1. You can select the category of the quote.\n\n2. You can copy any quote directly to your clipboard\n\n*NOTE*\n\nThis application scrapes the data from quotes.toscrape.com.'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'))
                                ],
                              );
                            });
                      },
                      icon:
                          const Icon(Icons.info_outline, color: Colors.black)),
                )
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: categories.map((category) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuotesPage(category))),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Center(
                      child: Text(
                        category.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
              indent: 10,
              endIndent: 10,
            ),
            isDataThere == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, bottom: 20),
                                child: Text(
                                  quotes[index],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(author[index],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 320,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: FloatingActionButton.small(
                                      heroTag: "btn1",
                                      backgroundColor: Colors.grey,
                                      onPressed: () {
                                        FlutterClipboard.copy(quotes[index])
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text('Successfully Copied!!'),
                                          ));
                                        });
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
