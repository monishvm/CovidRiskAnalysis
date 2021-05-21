import 'package:covid/components/questions/final_answer.dart';
import 'package:covid/components/questions/questions_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuesOptionBuilder extends StatefulWidget {
  QuesOptionBuilder(
      {this.indexofQues, this.question, this.options, this.tabController});
  final int indexofQues;
  final String question;
  final List options;
  final TabController tabController;

  @override
  _QuesOptionBuilderState createState() => _QuesOptionBuilderState();
}

class _QuesOptionBuilderState extends State<QuesOptionBuilder> {
  int currIndex;
  @override
  void initState() {
    super.initState();
    currIndex = widget.indexofQues;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _buildQuestion(),
          SizedBox(height: 30),
          _buildOptions(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.question,
        style: GoogleFonts.aBeeZee(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          reverse: true,
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            return optionTile(index);
          },
        ),
      ),
    );
  }

  bool isSelected(index) {
    return FinalAnswer.finalAns[widget.indexofQues]['op'] ==
        widget.options[index];
  }

  void moveToNext() {
    if (widget.indexofQues != Questions.ques.length - 1) {
      widget.tabController.animateTo(currIndex += 1);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(FinalAnswer.finalAns.toString()),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ok'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget optionTile(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FinalAnswer.finalAns[widget.indexofQues]['op'] =
              widget.options[index];
          moveToNext();
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected(index) ? Colors.grey : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.options[index],
            style: GoogleFonts.aBeeZee(
              fontSize: 19,
              color: isSelected(index) ? Colors.black : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
