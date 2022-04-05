import 'package:flutter/material.dart';
import '../../model/content_model.dart';
import '../components/custom_text.dart';

class Content extends StatelessWidget {
  static const String routeName = '/content';
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentModel;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Content"),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: CustomText(
                  text: args.title ?? '',
                  type: 'title',
                  color: 'white',
                  fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      color: const Color(0xff30445C),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text(
                                args.content ?? '',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                softWrap: true,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        )));
  }
}
