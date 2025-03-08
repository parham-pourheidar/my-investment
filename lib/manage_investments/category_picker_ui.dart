import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_investment/manage_investments/create_ui.dart';

class CategoryPickerPage extends StatelessWidget {
  const CategoryPickerPage({super.key});

  final double scale = 120;
  final double secondaryScale = 186;

  Widget categoryCard(
      String image, String name, ThemeData theme, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (_) => CreatePage(name)));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
            border: Border.all(
                color: theme.colorScheme.onSecondary.withOpacity(0.7)),
            gradient: LinearGradient(colors: [
              Colors.black,
              theme.colorScheme.primary.withOpacity(0.6)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: secondaryScale,
        height: secondaryScale,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                    border: Border.all(
                        color: theme.colorScheme.primary, width: 2.5),
                    borderRadius: const BorderRadius.all(Radius.circular(23))),
                width: scale,
                height: scale,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ))),
            const SizedBox(
              height: 5,
            ),
            Text(name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSecondary))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انتخاب دسته بندی',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 170,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                categoryCard(
                    'assets/images/dollar.webp', 'دلار', theme, context),
                categoryCard('assets/images/gold.webp', 'طلا', theme, context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}