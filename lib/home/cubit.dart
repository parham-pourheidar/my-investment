import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prices {
  int gold;
  int dollar;
  double goldChange;
  double dollarChange;

  Prices(this.gold, this.dollar, this.goldChange, this.dollarChange);
}

class PriceCubit extends Cubit<Prices> {
  PriceCubit() : super(Prices(0, 0, 100, 100));

  Future<void> update() async {

    Response response = await Dio().get(
        'https://brsapi.ir/FreeTsetmcBourseApi/Api_Free_Gold_Currency_v2.json');

    Prices state = Prices(
      response.data['gold'][6]['price'] ?? 0,
      response.data['currency'][0]['price'] ?? 0,
      response.data['gold'][6]['change_percent'].toDouble() ?? 0.0,
      response.data['currency'][0]['change_percent'].toDouble() ?? 0.0,
    );

    emit(state);
  }
}

Future<Prices> getInitData() async {
  Response response = await Dio().get(
      'https://brsapi.ir/FreeTsetmcBourseApi/Api_Free_Gold_Currency_v2.json');

  Prices state = Prices(
    response.data['gold'][6]['price'] ?? 0,
    response.data['currency'][0]['price'] ?? 0,
    response.data['gold'][6]['change_percent'].toDouble() ?? 0.0,
    response.data['currency'][0]['change_percent'].toDouble() ?? 0.0,
  );
  return state;
}

Future<List> getInitDataWithSp() async {
  Response response = await Dio().get(
      'https://brsapi.ir/FreeTsetmcBourseApi/Api_Free_Gold_Currency_v2.json');

  Prices state = Prices(
    response.data['gold'][6]['price'] ?? 0,
    response.data['currency'][0]['price'] ?? 0,
    response.data['gold'][6]['change_percent'].toDouble() ?? 0.0,
    response.data['currency'][0]['change_percent'].toDouble() ?? 0.0,
  );

  SharedPreferences instance = await SharedPreferences.getInstance();
  List keys = instance.getKeys().toList();
  return [state, keys, instance];
}