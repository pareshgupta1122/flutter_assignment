import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commonWidgets/text_widget.dart';
import '../../common_functions.dart';

class OptionContainer extends StatefulWidget {
  String option;
  bool isSelected;
  Function onTap;
  OptionContainer({
    Key? key,
    required this.option,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<OptionContainer> createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer> {
  double dW = 0.0;
  double tS = 0.0;
  TextTheme get textTheme => Theme.of(context).textTheme;
  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: EdgeInsets.only(bottom: dW * 0.04),
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: Container(
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
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: widget.isSelected
                                      ? Colors.orange
                                      : const Color(0xFF84858E),
                                  width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                              width: dW * 0.035,
                              height: dW * 0.035,
                              decoration: BoxDecoration(
                                  color: widget.isSelected
                                      ? Colors.orange
                                      : Colors.white,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          SizedBox(
                            width: dW * 0.03,
                          ),
                          SizedBox(
                            width: dW * 0.65,
                            child: TextWidget(
                              title: widget.option,
                              color: widget.isSelected
                                  ? Colors.orange
                                  : const Color(0xFF1D1E22),
                              fontSize: tS * 12,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
