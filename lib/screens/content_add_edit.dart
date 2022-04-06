import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../model/content_model.dart';
import '../services/ContentService.dart';
import 'content_view.dart';

class ProductAddEdit extends StatefulWidget {
  static const String routeName = '/edit-product';
  static const String routeNameAdd = '/add-product';
  const ProductAddEdit({Key? key}) : super(key: key);

  @override
  _ProductAddEditState createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  ContentModel? productModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Content'),
          elevation: 0,
        ),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: productForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    productModel = ContentModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        productModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
                context, "title", "Tutorial title", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'ContentName can\'t be empty.';
              }

              return null;
            },
                (onSavedVal) => {
                      productModel!.title = onSavedVal,
                    },
                initialValue: productModel!.title ?? "",
                obscureText: false,
                borderFocusColor: Colors.black,
                borderColor: Colors.black,
                textColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.7),
                borderRadius: 10,
                showPrefixIcon: false,
                backgroundColor: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
                context, "contentDescription", "Main Content", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'content can\'t be empty.';
              }

              return null;
            },
                (onSavedVal) => {
                      productModel!.content = onSavedVal,
                    },
                initialValue: productModel!.content ?? "",
                isMultiline: true,
                multilineRows: 10,
                obscureText: false,
                borderFocusColor: Colors.black,
                borderColor: Colors.black,
                textColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.7),
                borderRadius: 10,
                showPrefixIcon: false,
                backgroundColor: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Save", () {
              if (validateAndSave()) {
                // print(productModel!.toJson());

                setState(() {
                  isApiCallProcess = true;
                });

                APIService.saveContent(
                  productModel!,
                  isEditMode,
                  isImageSelected,
                ).then(
                  (response) {
                    setState(() {
                      isApiCallProcess = false;
                    });

                    if (response) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ContentView.routeName,
                        (route) => false,
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        'Git App',
                        "Error occur",
                        "OK",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                );
              }
            },
                btnColor: const Color(0xffE78230),
                borderColor: const Color(0xffE78230),
                txtColor: Colors.white,
                borderRadius: 10,
                width: MediaQuery.of(context).size.width - 40),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
