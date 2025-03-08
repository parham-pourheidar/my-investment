import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_investment/home/cubit.dart';
import 'package:animated_digit/animated_digit.dart';
import 'package:my_investment/show_investments/ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: getInitData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () {
                    return BlocProvider.of<PriceCubit>(context).update();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'تومان ',
                                  ),
                                  BlocBuilder<PriceCubit, Prices>(
                                      builder: (context, state) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 4.0),
                                        child: AnimatedDigitWidget(
                                          enableSeparator: true,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          value: state.gold == 0
                                              ? snapshot.data!.gold
                                              : state.gold,
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color:
                                            theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  BlocBuilder<PriceCubit, Prices>(
                                      builder: (context, state) => Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: AnimatedDigitWidget(
                                              enableSeparator: true,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              value: state.goldChange == 100
                                                  ? changeValueCalculate(
                                                  snapshot.data!.gold,
                                                  snapshot
                                                      .data!.goldChange)
                                                  : changeValueCalculate(
                                                  state.gold,
                                                  state.goldChange),
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: state.goldChange ==
                                                    100
                                                    ? changeColor(snapshot
                                                    .data!.goldChange)
                                                    : changeColor(
                                                    state.goldChange),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          state.goldChange == 100
                                              ? changeIcons(
                                              snapshot.data!.goldChange)
                                              : changeIcons(
                                              state.goldChange)
                                        ],
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '(هر گرم)',
                                    style: TextStyle(
                                        color: theme.colorScheme.onSecondary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  const Text(' طلا'),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: theme.colorScheme.primary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'تومان ',
                                  ),
                                  BlocBuilder<PriceCubit, Prices>(
                                      builder: (context, state) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 4.0),
                                        child: AnimatedDigitWidget(
                                          enableSeparator: true,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          value: state.dollar == 0
                                              ? snapshot.data!.dollar
                                              : state.dollar,
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color:
                                            theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  BlocBuilder<PriceCubit, Prices>(
                                      builder: (context, state) => Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: AnimatedDigitWidget(
                                              enableSeparator: true,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              value: state.dollarChange ==
                                                  100
                                                  ? changeValueCalculate(
                                                  snapshot.data!.dollar,
                                                  snapshot.data!
                                                      .dollarChange)
                                                  : changeValueCalculate(
                                                  state.dollar,
                                                  state.dollarChange),
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: state.dollarChange ==
                                                    100
                                                    ? changeColor(snapshot
                                                    .data!.dollarChange)
                                                    : changeColor(
                                                    state.dollarChange),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          state.dollarChange == 100
                                              ? changeIcons(snapshot
                                              .data!.dollarChange)
                                              : changeIcons(
                                              state.dollarChange)
                                        ],
                                      )),
                                ],
                              ),
                              const Text(' دلار'),
                            ],
                          ),
                          Divider(
                            color: theme.colorScheme.primary,
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
                                      duration:
                                      const Duration(milliseconds: 500),
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
                                      duration:
                                      const Duration(milliseconds: 500),
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
                                      duration:
                                      const Duration(milliseconds: 500),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.695,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {return const ShowInvestmentPage();}));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    theme.colorScheme.secondary),
                                fixedSize: const WidgetStatePropertyAll(
                                    Size(double.maxFinite, 55)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: theme.colorScheme.primary),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))))),
                            child: Text(
                              'مشاهده سرمایه',
                              style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => const HomePage()));
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
                return Center(child: SpinKitSpinningLines(color: theme.colorScheme.primary, size: 100, itemCount: 10, duration: const Duration(seconds: 5), lineWidth: 3,),);
              }
            },
          ),
        )
    );
  }
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
