import 'package:flutter/material.dart';
import 'package:flutter_assignment/commonWidgets/text_widget.dart';
import 'package:flutter_assignment/questionAnsModule/models/quesAns_model.dart';
import 'package:flutter_assignment/questionAnsModule/providers/quesAns_provider.dart';
import 'package:flutter_assignment/questionAnsModule/screens/selected_ans_screen.dart';
import 'package:flutter_assignment/questionAnsModule/widgets/custom_textfield.dart';
import 'package:flutter_assignment/questionAnsModule/widgets/option_container.dart';
import 'package:flutter_assignment/questionAnsModule/widgets/singleSelect_container.dart';
import 'package:provider/provider.dart';
import '../../common_functions.dart';
import '../widgets/custom_bottomsheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  double dH = 0.0;
  double dW = 0.0;
  double tS = 0.0;
  late QuestionnaireModel questionnaire;
  late Field field;
  String selectedOption = '';
  String selectedkey = '';

  int index = 0;
  TextEditingController numbericController = TextEditingController();
  TextEditingController textController = TextEditingController();

  bool isLoading = false;
  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
    questionnaire =
        Provider.of<QuesAnsProvider>(context, listen: false).getQues();

    field = questionnaire.fields[index];
    print(questionnaire);
  }

  @override
  Widget build(BuildContext context) {
    dH = MediaQuery.of(context).size.height;
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;

    field = questionnaire.fields[index];
    if (field.ans != null) {
      selectedOption = field.ans!;
      setState(() {});
    }
    return Scaffold(
      body: iOSCondition(dH) ? screenBody() : SafeArea(child: screenBody()),
    );
  }

  screenBody() {
    return SizedBox(
      height: dH,
      width: dW,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: dW * 0.05),
                  TextWidget(
                      title: questionnaire.title,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: dW * 0.1),
                  Container(
                    width: dW,
                    height: dW * 0.012,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: questionnaire.fields.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          width: (dW / questionnaire.fields.length) - dW * 0.02,
                          height: dH * 0.008,
                          child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: dW * 0.005),
                                  width: dW,
                                  height: dH * 0.015,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              if ((i == index && index > 0) ||
                                  i < index ||
                                  i == index)
                                FractionallySizedBox(
                                    widthFactor: 1,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: dW * 0.005),
                                      width: dW * 0.73,
                                      height: dH * 0.015,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: dW * 0.1,
                  ),
                  TextWidget(
                      title: field.schemma.label,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: dW * 0.03,
                  ),
                  if (field.type == 'Section')
                    ...field.schemma.fields!.map((e) => e.type == 'Numeric'
                        ? CustomTextField(
                            controller: numbericController,
                            label: e.schemma.label,
                            hintText: 'ex. Rs 500000',
                            onChanged: (_) {
                              e.ans = numbericController.text;
                            },
                            dW: dW,
                            tS: tS)
                        : e.type == 'Label'
                            ? CustomTextField(
                                isText: true,
                                controller: textController,
                                label: e.schemma.label,
                                onChanged: (_) {
                                  e.ans = textController.text;
                                },
                                hintText: 'ex. Uncle ',
                                dW: dW,
                                tS: tS)
                            : e.type == 'SingleSelect'
                                ? SingleSelectContainer(
                                    title: e.schemma.label,
                                    isSelected: e.ans != null,
                                    onTap: () {
                                      showModalBottomSheet(
                                        constraints:
                                            BoxConstraints(maxHeight: dH * 0.6),
                                            
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24),
                                          ),
                                        ),
                                        context: (context),
                                        builder: (context) => GestureDetector(
                                            onTap: () {},
                                            behavior: HitTestBehavior.opaque,
                                            child: CustombottomSheet(
                                                selectedKey:
                                                    e.ans == null ? '' : e.ans!,
                                                options: e.schemma.options!)),
                                      ).then((value) {
                                        if (value != null) {
                                          setState(() {
                                            selectedOption = value['name'];
                                            e.ans = value['name'];
                                            selectedkey = value['key'];
                                          });
                                        }
                                      });
                                    },
                                    option: e.ans == null
                                        ? 'Select a option'
                                        : e.ans!)
                                : e.type == 'SingleChoiceSelector'
                                    ? Column(
                                        children: [
                                          ...e.schemma.options!.map((e) =>
                                              OptionContainer(
                                                  isSelected: selectedOption ==
                                                      e['key'],
                                                  option: e['value'],
                                                  onTap: () {
                                                    selectedOption = e['key'];
                                                    field.ans = selectedOption;
                                                    setState(() {});
                                                  }))
                                        ],
                                      )
                                    : SizedBox()),
                  field.type == 'Numeric'
                      ? CustomTextField(
                          controller: numbericController,
                          label: field.schemma.label,
                          hintText: 'ex. Rs 500000',
                          onChanged: (_) {
                            field.ans = numbericController.text;
                          },
                          dW: dW,
                          tS: tS)
                      : field.type == 'Label'
                          ? CustomTextField(
                              isText: true,
                              controller: textController,
                              label: field.schemma.label,
                              onChanged: (_) {
                                field.ans = textController.text;
                              },
                              hintText: 'ex. Maa ',
                              dW: dW,
                              tS: tS)
                          : field.type == 'SingleSelect'
                              ? SingleSelectContainer(
                                  title: field.schemma.label,
                                  isSelected: field.ans != null,
                                  onTap: () {
                                    showModalBottomSheet(
                                      constraints:
                                          BoxConstraints(maxHeight: dH * 0.8),
                                      isScrollControlled: true,
                                      enableDrag: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      context: (context),
                                      builder: (context) => GestureDetector(
                                          onTap: () {},
                                          behavior: HitTestBehavior.opaque,
                                          child: CustombottomSheet(
                                              selectedKey: field.ans == null
                                                  ? ''
                                                  : field.ans!,
                                              options: field.schemma.options!)),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          selectedOption = value['name'];
                                          field.ans = value['name'];
                                          selectedkey = value['key'];
                                        });
                                      }
                                    });
                                  },
                                  option: field.ans == null
                                      ? 'Select a option'
                                      : field.ans!)
                              : SizedBox(),
                  if (field.schemma.options != null &&
                      field.type == 'SingleChoiceSelector')
                    ...field.schemma.options!.map((e) => OptionContainer(
                        isSelected: selectedOption == e['value'],
                        option: e['value'],
                        onTap: () {
                          selectedOption = e['value'];
                          field.ans = selectedOption;
                          setState(() {});
                        }))
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () {
                    if (index != 0 && index > 0) {
                      setState(() {
                        index--;
                        selectedOption = '';
                      });
                    }
                  },
                  child: const TextWidget(
                    title: 'Back',
                    fontSize: 18,
                  )),
              GestureDetector(
                onTap: () {
                  if (index + 1 < questionnaire.fields.length) {
                    setState(() {
                      index++;
                      selectedOption = '';
                    });
                  } else {
                    Provider.of<QuesAnsProvider>(context, listen: false)
                        .setMyValue(questionnaire);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AnswersScreen();
                    }));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(dW * 0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.orange),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: dW * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
