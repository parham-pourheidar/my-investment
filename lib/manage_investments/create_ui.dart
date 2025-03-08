import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_investment/show_investments/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePage extends StatelessWidget {
  final String category;
  const CreatePage(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ساخت سرمایه',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                maxLength: 30,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintFadeDuration: const Duration(seconds: 1),
                    hintStyle: TextStyle(color: theme.colorScheme.onSecondary),
                    hintText: 'نام سرمایه',
                    counterText: '',
                    fillColor: theme.colorScheme.secondary.withOpacity(0.35),
                    filled: true),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ,-]'))
                ],
                controller: amountController,
                maxLength: 30,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintFadeDuration: const Duration(seconds: 1),
                    hintStyle: TextStyle(color: theme.colorScheme.onSecondary),
                    hintText: category == 'طلا'
                        ? 'میزان سرمایه (به گرم)'
                        : 'میزان سرمایه',
                    counterText: '',
                    fillColor: theme.colorScheme.secondary.withOpacity(0.35),
                    filled: true),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 110,
              ),
              ElevatedButton(
                onPressed: () {
                  createInvestmentFunc(nameController.text,
                      amountController.text, context, category);
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        theme.colorScheme.secondary.withOpacity(0.4)),
                    fixedSize: const WidgetStatePropertyAll(Size(160, 55)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: theme.colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))))),
                child: Text(
                  'ایجاد سرمایه',
                  style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message,
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 20),
    )),
    backgroundColor: Theme.of(context).colorScheme.secondary,
    duration: const Duration(milliseconds: 2500),
    showCloseIcon: true,
    closeIconColor: Theme.of(context).colorScheme.onSecondary,
  ));
}

void createInvestmentFunc(
    String name, String amount, BuildContext context, String category) async {
  SharedPreferences instance = await SharedPreferences.getInstance();
  bool isStored = instance.getStringList(name) == null ? false : true;

  if (name == '') {
    snackBar(context, 'نام سرمایه را وارد کنید');
  } else if (amount == '') {
    snackBar(context, 'میزان سرمایه را وارد کنید');
  } else if (isStored) {
    snackBar(context, 'این نام قبلا استفاده شده است');
  } else {
    try {
      double.parse(amount);
      await instance.setStringList(name, [amount, category]);
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (_) => const ShowInvestmentPage()),
        (route) => false,
      );
    } catch (e) {
      snackBar(context, 'میزان سرمایه را به صورت عددی وارد کنید');
    }
  }
}