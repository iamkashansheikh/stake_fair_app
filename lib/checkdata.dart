import 'package:get/get.dart';

class BetController extends GetxController {
  final RxString betInput = ''.obs;
  final RxList<double> selectorValues = <double>[44, 0].obs;

  void addPreset(String label) {
    double current = double.tryParse(betInput.value) ?? 0;
    double addValue = double.tryParse(label.replaceAll('+', '')) ?? 0;
    betInput.value = (current + addValue).toStringAsFixed(0);
  }

  void onKeyTap(String val) {
    // If current betInput is 0, just replace it
    if (betInput.value == '0') {
      betInput.value = val;
    } else {
      betInput.value += val; // Or use just replace: betInput.value = val;
    }
  }

  void onBackspace() {
    if (betInput.value.isNotEmpty) {
      betInput.value = betInput.value.substring(0, betInput.value.length - 1);
    }
  }

  void decrement(int idx) {
    double current = double.tryParse(betInput.value) ?? 0;
    current = (current - 1).clamp(0, double.infinity);
    betInput.value = current.toStringAsFixed(0);
    selectorValues[idx]--;
  }

  void Inc(dynamic num) {
    selectorValues[num]--;
  }

  void Dec(dynamic num) {
    selectorValues[num]++;
  }

  void increment(int idx) {
    double current = double.tryParse(betInput.value) ?? 0;
    betInput.value = (current + 1).toStringAsFixed(0);
    selectorValues[idx]++;
  }

  void cancel() => betInput.value = '';
  void placeBet() =>
      print('Placing bet: ${betInput.value}, selectors: $selectorValues');

  var isOn = false.obs;
  void toggle() {
    isOn.value = !isOn.value;
  }
}



