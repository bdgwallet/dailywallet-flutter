import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_vibrate/flutter_vibrate.dart';

class NumPad extends ConsumerWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumPadButton(character: "1"),
            NumPadButton(character: "2"),
            NumPadButton(character: "3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumPadButton(character: "4"),
            NumPadButton(character: "5"),
            NumPadButton(character: "6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumPadButton(character: "7"),
            NumPadButton(character: "8"),
            NumPadButton(character: "9"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumPadButton(character: "."),
            NumPadButton(character: "0"),
            NumPadButton(character: "<"),
          ],
        )
      ],
    );
  }
}

class NumPadButton extends ConsumerWidget {
  const NumPadButton({super.key, required this.character});
  final String character;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return character == '<'
        ? TextButton(
            onPressed: () => removeFromNumPadValue(ref),
            style: TextButton.styleFrom(
                minimumSize: const Size(64, 64),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)))),
            child:
                Text(character, style: Theme.of(context).textTheme.bodyLarge),
          )
        : TextButton(
            onPressed: () => addToNumPadValue(ref, character),
            style: TextButton.styleFrom(
                minimumSize: const Size(64, 64),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)))),
            child:
                Text(character, style: Theme.of(context).textTheme.bodyLarge),
          );
  }
}

void addToNumPadValue(WidgetRef ref, String character) {
  var integerString = ref.watch(integerStringProvider);
  var decimalString = ref.watch(decimalStringProvider);
  final integerNotifier =
      ref.watch(integerStringProvider.notifier) as IntegerStringNotifier;
  final decimalNotifier =
      ref.watch(decimalStringProvider.notifier) as DecimalStringNotifier;
  /* final ctNotifier = ref.watch(currentTransactionProvider.notifier)
      as CurrentTransactionNotifier; */

  if (integerString.contains(".")) {
    // Limit to 2 decimals and don't allow multiple decimal signs
    if (decimalString.length < 2 && character != ".") {
      //Vibrate.feedback(FeedbackType.light);
      decimalString = decimalString + character;
      decimalNotifier.updateAmount(decimalString);
    } else {
      errorState(ref);
    }
  } else {
    // Limit to max 9999.99
    if (integerString.length < 4 || character == ".") {
      //Vibrate.feedback(FeedbackType.light);
      integerString = integerString + character;
      integerNotifier.updateAmount(integerString);
    } else {
      errorState(ref);
    }
  }

  if (character != ".") {
    String combinedValue =
        integerString.length > 0 ? integerString + decimalString : "0";
    double combinedDouble = double.parse(combinedValue);
    /* BigInt newAmount = combinedDouble.toUSDCBigInt();
    ctNotifier.updateAmount(newAmount); */
  }
}

void removeFromNumPadValue(WidgetRef ref) {
  var integerString = ref.watch(integerStringProvider);
  var decimalString = ref.watch(decimalStringProvider);
  final integerNotifier =
      ref.watch(integerStringProvider.notifier) as IntegerStringNotifier;
  final decimalNotifier =
      ref.watch(decimalStringProvider.notifier) as DecimalStringNotifier;
  /* final ctNotifier = ref.watch(currentTransactionProvider.notifier)
      as CurrentTransactionNotifier; */

  // Warn if integer is empty
  if (integerString == "0" || integerString == "") {
    integerString = "";
    integerNotifier.updateAmount(integerString);
    errorState(ref);
  }

  if (decimalString.length > 0) {
    // Delete decimals first, if present
    if (decimalString.length == 1) {
      // Delete only decimal + . from integer
      decimalString = "";
      decimalNotifier.updateAmount(decimalString);
      integerString = integerString.substring(0, integerString.length - 1);
      integerNotifier.updateAmount(integerString);
    } else if (decimalString.length > 0) {
      decimalString = decimalString.substring(0, decimalString.length - 1);
      decimalNotifier.updateAmount(decimalString);
    }
  } else {
    // No decimals, delete integers
    if (integerString == ".") {
      integerString = "";
    } else if (integerString.contains(".")) {
      integerString = integerString.substring(0, integerString.length - 2);
    } else if (integerString.length > 0) {
      integerString = integerString.substring(0, integerString.length - 1);
    }
    integerNotifier.updateAmount(integerString);
  }

  /* Vibrate.feedback(FeedbackType.light);
  String combinedValue = (integerString.length > 0 && integerString != ".")
      ? integerString + decimalString
      : "0";
  ctNotifier.updateAmount(double.parse(combinedValue).toUSDCBigInt()); */
}

void errorState(WidgetRef ref) {
  //Vibrate.feedback(FeedbackType.error);
  final eNotifier =
      ref.watch(amountErrorProvider.notifier) as AmountErrorNotifier;
  eNotifier.triggerError();
}

final integerStringProvider =
    StateNotifierProvider<StateNotifier<String>, String>(
        (ref) => IntegerStringNotifier());

class IntegerStringNotifier extends StateNotifier<String> {
  IntegerStringNotifier() : super("");

  @override
  String get state => super.state;

  @override
  set state(String value) => super.state = value;

  void updateAmount(String newAmount) {
    state = newAmount;
  }

  void reset() {
    state = "";
  }
}

final decimalStringProvider =
    StateNotifierProvider<StateNotifier<String>, String>(
        (ref) => DecimalStringNotifier());

class DecimalStringNotifier extends StateNotifier<String> {
  DecimalStringNotifier() : super("");

  @override
  String get state => super.state;

  @override
  set state(String value) => super.state = value;

  void updateAmount(String newAmount) {
    state = newAmount;
  }

  void reset() {
    state = "";
  }
}

final amountErrorProvider = StateNotifierProvider<StateNotifier<bool>, bool>(
    (ref) => AmountErrorNotifier());

class AmountErrorNotifier extends StateNotifier<bool> {
  AmountErrorNotifier() : super(false);

  @override
  bool get state => super.state;

  @override
  set state(bool value) => super.state = value;

  void triggerError() {
    state = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      state = false;
    });
  }

  void reset() {
    state = false;
  }
}
