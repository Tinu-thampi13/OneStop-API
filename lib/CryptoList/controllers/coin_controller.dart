import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/coin_model.dart';

class CoinController extends GetxController {
  RxList<Coin> coinsList = <Coin>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoin();
  }

  fetchCoin() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));
      List<Coin> coins = coinFromJson(response.body);
      coinsList.value = coins;
    } finally {
      isLoading(false);
    }
  }
}
