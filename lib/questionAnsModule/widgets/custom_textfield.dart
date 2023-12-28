import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commonWidgets/text_widget.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hintText;
  double dW;
  double tS;
  bool isText;
  Function(String)? onChanged;
  CustomTextField(
      {super.key,
      this.onChanged,
      this.isText = false,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.dW,
      required this.tS});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: dW * 0.05,
        ),
        TextWidget(title: label),
        SizedBox(
          height: dW * 0.03,
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: dW * 0.04,
              right: dW * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.orange,
              ),
            ),
            child: TextFormField(
              controller: controller,
              inputFormatters: [
                if (!isText) FilteringTextInputFormatter.digitsOnly
              ],
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: tS * 14,
                    letterSpacing: .4,
                  ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: tS * 14,
                  letterSpacing: .3,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                counterText: '',
                suffixIconConstraints: const BoxConstraints(),
              ),
              cursorColor: Colors.green,
              maxLength: isText ? 30 : 10,
              textInputAction: TextInputAction.done,
              keyboardType: isText ? TextInputType.text : TextInputType.number,
              onChanged: onChanged,
            )),
      ],
    );
  }
}
