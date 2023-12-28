import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commonWidgets/text_widget.dart';
import '../../common_functions.dart';
import '../models/quesAns_model.dart';
import '../providers/quesAns_provider.dart';

class AnswersScreen extends StatefulWidget {
  const AnswersScreen({Key? key}) : super(key: key);

  @override
  AnswersScreenState createState() => AnswersScreenState();
}

class AnswersScreenState extends State<AnswersScreen> {
  double dH = 0.0;
  double dW = 0.0;
  double tS = 0.0;
  bool isLoading = false;
  late QuestionnaireModel questionnaire;
  TextTheme get textTheme => Theme.of(context).textTheme;

  fetchData() async {
    setState(() => isLoading = true);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    questionnaire =
        Provider.of<QuesAnsProvider>(context, listen: false).questionnaire;
  }

  @override
  Widget build(BuildContext context) {
    dH = MediaQuery.of(context).size.height;
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: dW * 0.05),
            const TextWidget(
                title: 'Answers', fontSize: 30, fontWeight: FontWeight.w600),
            //SizedBox(height: dW * 0.05),
            Expanded(
              child: ListView.builder(
                  itemCount: questionnaire.fields.length,
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (questionnaire.fields[i].ans != null ||
                            questionnaire.fields[i].schemma.fields != null) ...[
                          SizedBox(
                            height: dW * 0.08,
                          ),
                          TextWidget(
                              title:
                                  'Q${i + 1} ${questionnaire.fields[i].schemma.label}',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          SizedBox(height: dW * 0.03),
                        ],
                        if (questionnaire.fields[i].ans != null) ...[
                          Container(
                            width: dW,
                            padding: EdgeInsets.symmetric(
                                horizontal: dW * 0.06, vertical: dW * 0.035),
                            // constraints: BoxConstraints(minHeight: dW * 0.12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 1, color: Colors.orange),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextWidget(
                                title: questionnaire.fields[i].ans!,
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                        if (questionnaire.fields[i].schemma.fields != null)
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: questionnaire
                                  .fields[i].schemma.fields!.length,
                              itemBuilder: (context, j) {
                                var morefields =
                                    questionnaire.fields[i].schemma.fields;
                                return questionnaire.fields[i].schemma.fields !=
                                        null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (i != 0)
                                            if (questionnaire.fields[i].schemma
                                                    .fields![j].ans !=
                                                null) ...[
                                              SizedBox(
                                                height: dW * 0.04,
                                              ),
                                              TextWidget(
                                                  title: questionnaire
                                                      .fields[i]
                                                      .schemma
                                                      .fields![j]
                                                      .schemma
                                                      .label,
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                              SizedBox(height: dW * 0.03),
                                            ],
                                          if (questionnaire.fields[i].schemma
                                                  .fields![j].ans !=
                                              null)
                                            Container(
                                              width: dW,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: dW * 0.06,
                                                  vertical: dW * 0.035),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.orange),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: TextWidget(
                                                  title: questionnaire.fields[i]
                                                      .schemma.fields![j].ans!,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                        ],
                                      )
                                    :const SizedBox.shrink();
                              }),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: dW * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
