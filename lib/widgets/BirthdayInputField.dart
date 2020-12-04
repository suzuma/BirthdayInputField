import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //FOR FilteringTextInputFormatter

final List<TextInputFormatter> numberInputFormatters = [
  FilteringTextInputFormatter.deny('.'),
  FilteringTextInputFormatter.deny('-'),
  FilteringTextInputFormatter.deny(' '),
  FilteringTextInputFormatter.deny(','),
];

const styleForErrorText = TextStyle(
  color: Colors.redAccent,
  fontSize: 12,
);

class BirthdayInputField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final dayCtrl = useTextEditingController();
    // final monthCtrl = useTextEditingController();
    // final yearCtrl = useTextEditingController();

    final dayState = useState("0");
    final monthState = useState("0");
    final yearState = useState("0");

    final dayFocus = useFocusNode();
    final monthFocus = useFocusNode();
    final yearFocus = useFocusNode();

    // final formStatus = useState<bool>(null);

    final dayIsValid = useState<bool>(null);
    final monthIsValid = useState<bool>(null);
    final yearIsValid = useState<bool>(null);

    useValueChanged(dayState.value, (_, oldResult) {
      print("dayState.value = ${dayState.value}");
      print(oldResult);
      final day = int.parse(dayState.value);

      final compare = day > 0 && day <= 31;

      if (compare != oldResult) dayIsValid.value = compare;

      return compare; // oldResult
    });
    useValueChanged(monthState.value, (_, oldResult) {
      print("monthState.value = ${monthState.value}");

      final month = int.parse(monthState.value);

      final compare = month > 0 && month <= 12;

      if (compare != oldResult) monthIsValid.value = compare;

      return compare; // oldResult
    });
    useValueChanged(yearState.value, (_, oldResult) {
      print("yearState.value = ${yearState.value}");

      final year = int.parse(yearState.value);

      final compare = year >= 1930 && year < DateTime.now().year;

      if (compare != oldResult) yearIsValid.value = compare;

      return compare; // oldResult
    });

    const slashStyle = TextStyle(color: Colors.black38);

    final formStatus = dayIsValid.value != null && !dayIsValid.value ||
        monthIsValid.value != null && !monthIsValid.value ||
        yearIsValid.value != null && !yearIsValid.value;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            // color: Color(0xFFE5E5E5),
            border: Border.all(
              color: formStatus ? Colors.redAccent : Colors.black38,
              width: formStatus ? 2 : 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: InkWell(
            onTap: () => FocusScope.of(context).requestFocus(dayFocus),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(FontAwesomeIcons.birthdayCake),
                Spacer(),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // controller: dayCtrl,
                    focusNode: dayFocus,
                    decoration: InputDecoration.collapsed(
                      hintText: "DD",
                    ),
                    inputFormatters: numberInputFormatters,
                    maxLength: 2,
                    onChanged: (val) {
                      // if (val.length == 2) {
                      //   FocusScope.of(context).requestFocus(monthFocus);
                      // }
                      if (val.isEmpty) return;
                      dayState.value = val;
                    },
                    buildCounter: (context,
                            {currentLength, isFocused, maxLength}) =>
                        null,
                  ),
                ),
                Text("/", style: slashStyle),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // controller: monthCtrl,
                    focusNode: monthFocus,
                    decoration: InputDecoration.collapsed(hintText: "MM"),
                    inputFormatters: numberInputFormatters,
                    maxLength: 2,
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      monthState.value = val;
                    },
                    buildCounter: (context,
                            {currentLength, isFocused, maxLength}) =>
                        null,
                  ),
                ),
                Text("/", style: slashStyle),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration.collapsed(hintText: "AAAA"),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny('.'),
                      FilteringTextInputFormatter.deny('-'),
                      FilteringTextInputFormatter.deny(' '),
                      FilteringTextInputFormatter.deny(','),
                    ],
                    // textInputAction: TextInputAction.next,
                    focusNode: yearFocus,
                    // controller: yearCtrl,
                    maxLength: 4,
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      yearState.value = val;
                    },
                    buildCounter: (context,
                            {currentLength, isFocused, maxLength}) =>
                        null,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dayIsValid?.value ?? true
                ? Text("")
                : Text("Día incorrecto!", style: styleForErrorText),
            monthIsValid?.value ?? true
                ? Text("")
                : Text("Mes incorrecto!", style: styleForErrorText),
            yearIsValid?.value ?? true
                ? Text("")
                : Text("Año incorrecto!", style: styleForErrorText),
          ],
        ),
      ],
    );
  }
}
