import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../model/content_model.dart';
import '../services/ContentService.dart';
import 'content_item_backend.dart';

class ContentList extends StatefulWidget {
  static const String routeName = '/content-list';
  const ContentList({Key? key}) : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  List<ContentModel> products = List<ContentModel>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        // child: productList(products),
        child: loadProducts(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getContent(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ContentModel>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Button(
                    title: 'Add content',
                    color: const Color(0xffE78230),
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        '/add-product',
                      );
                    }),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return BackEndItem(
                    model: products[index],
                    onDelete: (ContentModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIService.deleteContent(model.id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
