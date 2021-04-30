import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

//creating object of quizbrain
QuizBrain quizBrain=new QuizBrain();

void main()=>runApp(quizapp());


class quizapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.grey.shade900,
        body:SafeArea(
          child:QuizePage(),
        ),
      ),
    );
  }
}
class QuizePage extends StatefulWidget {
  @override
  _QuizePageState createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizePage> {

  // List<String> questions=[
  //   'You can lead a cow downstairs but not upstairs',
  // 'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  // List<bool> answers=[false,true,true];
  // Question q=new Question(q:'You can lead a cow downstairs but not upstairs',a:false);


  List<Widget> ScoreKeeper=[];
  void checkAnswer(bool userPickedAnswer)
  {
    bool correctAnswer=QuizBrain().getQuestionAnswer();
    //print('$correctAnswer');
    setState(()
    {
      if(quizBrain.isFinished() == true)
        {
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();

          quizBrain.reset();
          ScoreKeeper = [];

        }
      else
        {
      if(correctAnswer==userPickedAnswer){
        print('$correctAnswer');
        print('$userPickedAnswer');
            ScoreKeeper.add(Icon(Icons.check,color: Colors.green));
        }
      else
      {
       ScoreKeeper.add(Icon(Icons.close,color: Colors.red));
      }
      quizBrain.nextQuestion();
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children:<Widget> [
        Expanded(
          flex:5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
               quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontSize: 20.0,
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ),
        ),

        Expanded(

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
              onPressed: (){
            checkAnswer(true);

    },
                child:Text('True',
                style:TextStyle(fontSize:20.0,
                  color:Colors.white,

                ),
                ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style:TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: (){
              checkAnswer(false);

              },
            child:Text('False',
            style:TextStyle(
                fontSize: 20.0,
                color:Colors.white),
            ),
              ),

          ),
        ),
        Row(
          children:ScoreKeeper,
        ),
      ],

    );
  }
}


