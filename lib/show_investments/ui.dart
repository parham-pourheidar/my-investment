import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_investment/manage_investments/category_picker_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_digit/animated_digit.dart';
import 'package:my_investment/home/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_investment/manage_investments/edit_ui.dart';

class ShowInvestmentPage extends StatelessWidget {
  const ShowInvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getInitDataWithSp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () {
                  return BlocProvider.of<PriceCubit>(context).update();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ui(context, theme, snapshot),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'اتصال اینترنت خود را بررسی کنید',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const ShowInvestmentPage()));
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
                      'تلاش مجدد',
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ));
            } else {
              return Center(
                child: SpinKitSpinningLines(
                  color: theme.colorScheme.primary,
                  size: 100,
                  itemCount: 10,
                  duration: const Duration(seconds: 5),
                  lineWidth: 3,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1.4)),
        onPressed: () {
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (_) => const CategoryPickerPage()));
        },
        child: Icon(
          Icons.add_rounded,
          size: 44,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

Widget tile(
    BuildContext context, ThemeData theme, AsyncSnapshot snapshot, int index) {
  List data = snapshot.data[2].getStringList(snapshot.data[1][index]);
  double amount = double.parse(data[0]);

  return Card(
    shadowColor: Colors.black,
    elevation: 12,
    child: ExpansionTile(
      title: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'تومان ',
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      BlocBuilder<PriceCubit, Prices>(
                          builder: (context, state) {
                            int statePrice =
                            data[1] == 'طلا' ? state.gold : state.dollar;
                            int snapshotPrice = data[1] == 'طلا'
                                ? snapshot.data[0]!.gold
                                : snapshot.data[0]!.dollar;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: AnimatedDigitWidget(
                                enableSeparator: true,
                                duration: const Duration(milliseconds: 500),
                                value: state.gold == 0
                                    ? snapshotPrice * amount
                                    : statePrice * amount,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            );
                          }),
                      BlocBuilder<PriceCubit, Prices>(
                          builder: (context, state) {
                            int statePrice =
                            data[1] == 'طلا' ? state.gold : state.dollar;
                            int snapshotPrice = data[1] == 'طلا'
                                ? snapshot.data[0]!.gold
                                : snapshot.data[0]!.dollar;
                            double changeStatePrice = data[1] == 'طلا'
                                ? state.goldChange
                                : state.dollarChange;
                            double changeSnapshotPrice = data[1] == 'طلا'
                                ? snapshot.data[0]!.goldChange
                                : snapshot.data[0]!.dollarChange;
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: AnimatedDigitWidget(
                                    enableSeparator: true,
                                    duration: const Duration(milliseconds: 500),
                                    value: state.goldChange == 100
                                        ? changeValueCalculate(snapshotPrice,
                                        changeSnapshotPrice) *
                                        amount
                                        : changeValueCalculate(
                                        statePrice, changeStatePrice) *
                                        amount,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: state.goldChange == 100
                                          ? changeColor(
                                          snapshot.data[0]!.goldChange)
                                          : changeColor(state.goldChange),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                state.goldChange == 100
                                    ? changeIcons(snapshot.data[0]!.goldChange)
                                    : changeIcons(state.goldChange)
                              ],
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Expanded(child: Center()),
          Text(
            snapshot.data[1][index],
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ],
      ),
      backgroundColor:
      Theme.of(context).colorScheme.secondary.withOpacity(0.35),
      collapsedBackgroundColor:
      Theme.of(context).colorScheme.secondary.withOpacity(0.35),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )),
      controlAffinity: ListTileControlAffinity.leading,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              backgroundColor: theme.colorScheme.onPrimary,
                              title: Center(
                                  child: Text(
                                    'آیا مطمئن هستید؟',
                                    style: TextStyle(
                                        color: theme.colorScheme.secondary),
                                  )),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences instance = await SharedPreferences.getInstance();
                                        await instance.remove(snapshot.data[1][index]);
                                        Navigator.pop(context);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ShowInvestmentPage()));
                                      },
                                      child: const Text(
                                        'بله',
                                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () { Navigator.of(context).pop(); },
                                      child: Text(
                                        'خیر',
                                        style: TextStyle(
                                            color: theme.colorScheme.secondary, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.delete_rounded)),
                IconButton(onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) => EditPage(data[1], snapshot.data[1][index], data[0])));
                }, icon: const Icon(Icons.edit)),
              ],
            ),
            Column(
              children: [
                const Text(':میزان سرمایه'),
                Row(
                  children: [
                    Text(data[1] == 'دلار' ? '' : 'گرم '),
                    Text(data[0]),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: Column(
                children: [
                  const Text(':دسته'),
                  Text(data[1]),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

double changeValueCalculate(int value, double valueChange) {
  if (valueChange != 0) {
    return value - (value / (1 + (valueChange / 100)));
  } else {
    return 0;
  }
}

Color changeColor(value) {
  if (value > 0) {
    return Colors.green;
  } else if (value < 0) {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

Widget changeIcons(value) {
  if (value > 0) {
    return const Icon(
      Icons.arrow_upward_rounded,
      color: Colors.green,
      size: 18,
    );
  } else if (value < 0) {
    return const Icon(
      Icons.arrow_downward_rounded,
      color: Colors.red,
      size: 18,
    );
  } else {
    return const Center();
  }
}

Widget ui(context, theme, snapshot){
  if (snapshot.data![1].length == 0){
    return
        const Center(child: Text('هنوز موردی برای نمایش وجود ندارد', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),));
  }
  else{
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.835,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return tile(context, theme, snapshot, index);
            },
            itemCount: snapshot.data![1].length,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<PriceCubit, Prices>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ':آخرین به روز رسانی ',
                style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w100),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedDigitWidget(
                    value: DateTime.now().hour,
                    duration: const Duration(milliseconds: 500),
                    textStyle: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  AnimatedDigitWidget(
                    value: DateTime.now().minute,
                    duration: const Duration(milliseconds: 500),
                    textStyle: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  AnimatedDigitWidget(
                    value: DateTime.now().second,
                    duration: const Duration(milliseconds: 500),
                    textStyle: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}