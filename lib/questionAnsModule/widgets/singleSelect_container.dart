import 'package:flutter/material.dart';

import '../../commonWidgets/text_widget.dart';

class SingleSelectContainer extends StatefulWidget {
  String option;
  String title;
  bool isSelected;
  Function onTap;
  SingleSelectContainer(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.option,
      required this.title});

  @override
  State<SingleSelectContainer> createState() => _SingleSelectContainerState();
}

class _SingleSelectContainerState extends State<SingleSelectContainer> {
  double dW = 0.0;
  double tS = 0.0;
  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(title: widget.title),
          SizedBox(height: dW * 0.03),
          Container(
            width: dW,
            padding: widget.isSelected
                ? EdgeInsets.symmetric(
                    horizontal: (dW * 0.06) - 1, vertical: (dW * 0.035) - 1)
                : EdgeInsets.symmetric(
                    horizontal: dW * 0.06, vertical: dW * 0.035),
            // constraints: BoxConstraints(minHeight: dW * 0.12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: widget.isSelected
                  ? Border.all(width: 1, color: Colors.orange)
                  : Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: dW * 0.65,
                  child: TextWidget(
                    title: widget.option,
                    color: widget.isSelected
                        ? Colors.orange
                        : const Color(0xFF1D1E22),
                    fontSize: tS * 14,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                ),
               const Icon(Icons.arrow_drop_down_rounded)
              ],
            ),
          ),
          SizedBox(
            height: dW * 0.04,
          )
        ],
      ),
    );
  }
}
