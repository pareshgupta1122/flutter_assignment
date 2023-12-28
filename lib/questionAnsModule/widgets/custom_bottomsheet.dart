import 'package:flutter/material.dart';

import '../../commonWidgets/text_widget.dart';
import '../../common_functions.dart';

class CustombottomSheet extends StatefulWidget {
  final List<Map> options;
  final String selectedKey;
  const CustombottomSheet(
      {super.key, required this.options, required this.selectedKey});

  @override
  State<CustombottomSheet> createState() => _CustombottomSheetState();
}

class _CustombottomSheetState extends State<CustombottomSheet> {
  double dW = 0.0;
  double tS = 0.0;
  String selectedOptionId = '';
  String selectedOption = '';

  aboutQuesOptions({required genderString, required ansId}) {
    bool isSelected = genderString == selectedOption;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOptionId = ansId;
              selectedOption = genderString;

              pop({'key': selectedOptionId, 'name': selectedOption});
            });
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: dW * 0.03),
            child: Row(
              children: [
                TextWidget(
                  title: genderString,
                  color: const Color(0xFF505050),
                  fontSize: tS * 14,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isSelected
                            ? Colors.orange
                            : const Color(0xFFC9CED6),
                        width: 2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    width: dW * 0.03,
                    height: dW * 0.03,
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: Color(
            0xffDDE9FD,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedKey != '') {
      selectedOption = widget.selectedKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: dW * 0.1),
                      const TextWidget(
                        textAlign: TextAlign.center,
                        title: 'Select a Option',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff37383F),
                      ),
                      // SizedBox(height: dW * 0.04),
                      // TextWidget(
                      //     textAlign: TextAlign.center,
                      //     title: language['moreaboutGender'],
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //     color: subTitle),
                      SizedBox(height: dW * 0.05),
                      Column(children: [
                        ...widget.options.map((option) => aboutQuesOptions(
                            genderString: option['value'],
                            ansId: option['key'])),
                      ]),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
