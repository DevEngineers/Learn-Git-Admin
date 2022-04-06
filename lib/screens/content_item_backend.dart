import 'package:flutter/material.dart';
import '../model/content_model.dart';

class BackEndItem extends StatelessWidget {
  final ContentModel? model;
  final Function? onDelete;

  const BackEndItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: const Color(0xff30445C),
      child: SizedBox(
        width: 200,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/content',
              arguments: model,
            );
          },
          child: cartItem(context),
        ),
      ),
    );
  }

  Widget cartItem(context) {
    return SizedBox(
      height: 130,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${model!.content}",
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/edit-product',
                            arguments: {
                              'model': model,
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          onDelete!(model);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
