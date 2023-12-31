import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myskul/components/form_inputs.dart';
import 'package:myskul/controllers/payment_controller.dart';
import 'package:myskul/controllers/product_controller.dart';
import 'package:myskul/models/payment.dart';
import 'package:myskul/models/product.dart';
import 'package:myskul/utilities/helpers.dart';
import 'package:myskul/utilities/validators.dart';

class PurchaseProduct extends StatefulWidget {
  final Product product;
  PurchaseProduct({super.key, required this.product});

  @override
  State<PurchaseProduct> createState() => _PurchaseProductState();
}

class _PurchaseProductState extends State<PurchaseProduct> {
  List<PaymentMethod> _paymentMethods = [];
  String? _pMethod;
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _loadData() async {
    _paymentMethods = await PaymentController.getPaymentMethods();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Acheter produit", context: context),
      body: Container(
        decoration: getBckDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Text(
              "Montant produit: ${widget.product.price} U",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Entrez vos informations de paiement et finaliser l'achat",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    child: ListView(children: [
                      SizedBox(height: 20),
                      LabelText(label: "Type"),
                      DropdownMenuInputStr(
                          items: _getPaymentMethods(_paymentMethods),
                          defaultValue: _pMethod,
                          validator: stringValidator,
                          onChanged: (value) {
                            setState(() {
                              _pMethod = value;
                            });
                          }),
                      SizedBox(height: 30),
                      LabelText(label: "Numéro téléphone"),
                      TextFieldInput(
                        controller: _phoneController,
                        validator: (value) =>
                            phoneNumValidator(value, _getRegex()),
                        textInputType: TextInputType.number,
                      ),
                    ]),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Center(
                              child: Text(
                                "Acheter",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF22987F),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF22987F)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ProductController.purchase(
                                  productId: widget.product.id.toString(),
                                  serviceId: _pMethod!,
                                  amount: widget.product.price.toString(),
                                  phoneNumber: _phoneController.text)
                              .then((value) {
                            if (value) {
                              EasyLoading.showSuccess(
                                  "Votre processus d'acaht a bien été enclanché, vous recevrez un message pour valider votre paiement.");
                              Navigator.pop(context);
                              ;
                            }
                          });
                        } else {
                          EasyLoading.showInfo(
                              "Veuillez valider tous les champs");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getPaymentMethods(
      List<PaymentMethod> methods) {
    List<DropdownMenuItem<String>> items = [];
    for (var t in methods) {
      items.add(DropdownMenuItem(
        child: Text("${t.displayName}"),
        value: t.payItemId,
      ));
    }
    return items;
  }

  String _getRegex() {
    for (var element in _paymentMethods) {
      if (element.payItemId == _pMethod) {
        return element.regex!;
      }
    }
    return "";
  }
}
